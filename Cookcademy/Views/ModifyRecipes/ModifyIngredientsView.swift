//
//  ModifyIngredientsView.swift
//  Cookcademy
//
//  Created by Kevin Martinez on 1/4/24.
//

import SwiftUI

struct ModifyIngredientsView: View {
    
    @Binding var ingredients: [Ingredient]
    @State var newIngredient = Ingredient()
    

    
    var body: some View {
        VStack {
            if ingredients.isEmpty {
                emptyView
            } else {
                ingredientList
            }
        }
        }
    }


//MARK: - ModifyINgredientsView extension

extension ModifyIngredientsView {
    
    var emptyView: some View {
        ContentUnavailableView(label: {
            Label("No Ingredients", systemImage: "list.bullet.rectangle.fill")
        }, description: {
            Text("New ingrediets you add will appear here.")
        }, actions: {
            NavigationLink {
                
                ModifyIngredientView(ingredient: $newIngredient) { ingredient in
                    ingredients.append(ingredient)
                    newIngredient = Ingredient()
                }
                
                
            } label: {
                Label(
                    title: { Text("Add New Ingredient").bold() },
                    icon: { Image(systemName:
                                "plus.circle").font(.title3) }
                )
            }
            .frame(width: 200, height: 35)
            .background(RoundedRectangle(cornerRadius: 25.0 ).foregroundStyle(.cusumBackground))
            
        })
        
        .foregroundStyle(.accent)
    }
    
    var ingredientList: some View {
        List {
            
            
           
            Group {
                ForEach (ingredients) { ingredient in
                        Text(ingredient.description)
                }
           
            
            NavigationLink {
                ModifyIngredientView(ingredient: $newIngredient) { ingredient in
                    ingredients.append(ingredient)
                    newIngredient = Ingredient()
                }
            } label: {
                Label(
                    title: { Text("Add another Ingredient") },
                    icon: { Image(systemName: "plus.circle.fill") }
                )
            }
            
            }
            .listRowBackground(Color.cusumBackground)
            .foregroundStyle(.accent)

        }
       
    }
}

//MARK: - Preview

#Preview {
    
    NavigationStack {
        ModifyIngredientsView(ingredients: .constant([Ingredient]()))
    }
}

#Preview {
    NavigationStack {
        ModifyIngredientsView(ingredients: .constant(Recipe.testRecipes[0].ingredients))
    }
}
