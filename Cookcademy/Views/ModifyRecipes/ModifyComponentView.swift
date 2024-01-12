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

struct ModifyComponentsView<Component: RecipeComponent, DestinationView: ModifyComponentView>: View where DestinationView.Component == Component, DestinationView.Component: Hashable  {
    
    @Binding var components: [Component]
    @State private var newComponent = Component()
    @State private var editMode: EditMode = .inactive
    
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
                .navigationTitle("Add \(labelComponent.capitalized)")
                
                
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
       Group {
     
           
           LabeledContent {
               // Using edit button give a funky animation everytime we move and delete a component solve this by using editMode enviroment
               Button {
                   withAnimation {
                       editMode = editMode == .inactive ? .active : .inactive
                   }
               } label: {
                   withAnimation {
                       Text(editMode == .inactive ? "Edit" : "Done")
                   }
               }
               
           } label: {
               Text(labelComponent + "s")
                   .font(.title2)
                   .bold()
           }
           
           .underline()
           .foregroundStyle(.accent)
           .padding()
       
      
           
    
           List {
               
                Group {
                    
                    ForEach (components) { component in
                        NavigationLink(value: component) {
                            Text(component.description)
                        }

                    }
                    .onDelete{components.remove(atOffsets: $0)}
                    .onMove(perform: { indices, newOffset in
                        withAnimation {
                            components.move(fromOffsets: indices, toOffset: newOffset)
                        }
                       
                    })
                  
                NavigationLink {
                   
                    DestinationView(component: $newComponent) { component in
                        components.append(component)
                        newComponent = Component()
                    }
                    .navigationTitle("Add \(labelComponent.capitalized)")
                    
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
           .environment(\.editMode, $editMode)
          
      
           
           
            .navigationDestination(for: Component.self) { component in
                DestinationView(component: binding(for: component)) { _ in
                    return
                }
                .navigationTitle("Edit \(labelComponent.capitalized)")
        }
      }
       
       
    }
    
    
    
    
    func binding(for component: Component) -> Binding<Component> {
        
        guard let index = components.firstIndex(where: {component.id == $0.id}) else {
            fatalError("Recipe not found")
        }
        return $components[index]
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
