//
//  RecipesListView.swift
//  Cookcademy
//
//  Created by Kevin Martinez on 12/26/23.
//

import SwiftUI

struct RecipesListView: View {
    
    @Environment(RecipeData.self) var recipeDataVM
    let category: MainInformation.Category
    
    @State private var isPresenting = false
    @State private var newRecipe = Recipe()
    
    var body: some View {
        List {
            ForEach(recipes) { recipe in
                NavigationLink(value: recipe) {
                    Text(recipe.mainInformation.name)
                        
                }
                .listRowBackground(Color.cusumBackground)
            }
        }
        .toolbar {
            ToolbarItem (placement: .topBarTrailing) {
                Button ("Add New Recipe", systemImage: "plus") {
                    isPresenting.toggle()
                }
                .tint(Color.customForeground)
            }
            
        }
        .sheet(isPresented: $isPresenting) {
            NavigationStack {
                ModifyRecipeView(recipe: $newRecipe)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Dismiss") {
                                isPresenting.toggle()
                            }
                        }
                        
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Add") {
                                recipeDataVM.recipes.append(newRecipe)
                                isPresenting.toggle()
                            }
                        }
                        
                    }
                    .navigationTitle("Add a New Recipe")
            }
        }
        .foregroundStyle(Color.customForeground)
        .navigationDestination(for: Recipe.self) { recipe in
            RecipeDetailView(recipe: recipe )
        }
        .navigationTitle(navigationTitle)
    }
}


//MARK: - RecipeListView Extention

extension RecipesListView {
    
    var recipes: [Recipe] { recipeDataVM.recipes(for: category) }

    // navigation title could be add in a constant extructure
    var navigationTitle: String { "\(category.rawValue) Recipes" }
    
  
}

//MARK: - preview

#Preview {
    NavigationStack {
        RecipesListView(category: .breakfast)
            .environment(RecipeData())
    }
}
