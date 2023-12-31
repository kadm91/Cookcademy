//
//  ModifyComponentsView.swift
//  Cookcademy
//
//  Created by Kevin Martinez on 1/4/24.
//

protocol RecipeComponent: CustomStringConvertible, Identifiable {
    init()
}

protocol ModifyComponentView: View {
    associatedtype Component
    init(component: Binding<Component>, createAction: @escaping (Component) -> Void)
}


import SwiftUI

struct ModifyComponentsView<Component: RecipeComponent, DestinationView: ModifyComponentView>: View where DestinationView.Component == Component  {
    
    @Binding var components: [Component]
    @State var newComponent = Component()
    private var labelComponent: String {
        if Component() is Ingredient {
            return "Ingredient"
        } else {
            return "Direction"
        }
    }
 
    
    var body: some View {
        VStack {
            if components.isEmpty {
                emptyView
            } else {
                ingredientList
            }
        }
        }
    }


//MARK: - ModifyINgredientsView extension

extension ModifyComponentsView {
    
    var emptyView: some View {
        ContentUnavailableView(label: {
            Label("No \(labelComponent + "s")", systemImage: labelComponent == "Ingredient" ? "list.bullet.rectangle.fill" : "list.bullet.rectangle")
        }, description: {
            Text("New \(labelComponent.lowercased() + "s") you add will appear here.")
        }, actions: {
            
            NavigationLink {
                
           
                DestinationView(component: $newComponent) { component in
                    components.append(component)
                    newComponent = Component()
                }
                
                
                
            } label: {
                Label(
                    title: { Text("Add New \(labelComponent.lowercased())").bold() },
                    icon: { Image(systemName:
                                "plus.circle").font(.title3) }
                )
            }
            .frame(width: 200, height: 35)
            .background(RoundedRectangle(cornerRadius: 25.0 ).foregroundStyle(.cusumBackground))
            
        }
        
        
        )
        
        .foregroundStyle(.accent)
    }
    
    var ingredientList: some View {
        List {

            Group {
                
                ForEach (components) { Text($0.description) }
              
            NavigationLink {
               
                DestinationView(component: $newComponent) { component in
                    components.append(component)
                    newComponent = Component()
                }
                
            } label: {
                Label(
                    title: { Text("Add another \(labelComponent.lowercased())") },
                    icon: { Image(systemName: "plus.circle.fill") }
                )
            }
            
            }
            .listRowBackground(Color.cusumBackground)
            .foregroundStyle(.accent)
        }
    }
}

//MARK: - Ingredient Previews

#Preview ("Empty Ingredient List") {
    
    NavigationStack {
        ModifyComponentsView<Ingredient, ModifyIngredientView>(components: .constant([Ingredient]()))
    }
}

#Preview ("Display Ingredient List") {
    NavigationStack {
        ModifyComponentsView<Ingredient, ModifyIngredientView>(components: .constant(Recipe.testRecipes[0].ingredients))
    }
}

//MARK: - Direction Previews

#Preview ("Empty Directions List") {
    NavigationStack {
        ModifyComponentsView<Direction, ModifyDirectionView>(components: .constant([Direction]()))
    }
}

#Preview ("Dispalay Directions List") {
    NavigationStack {
        ModifyComponentsView<Direction, ModifyDirectionView>(components: .constant(Recipe.testRecipes[0].directions))
    }
}
