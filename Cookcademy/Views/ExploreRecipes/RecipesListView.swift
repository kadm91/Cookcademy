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
                                newRecipe = Recipe()
                                isPresenting.toggle()
                            }
                        }
                        
                        ToolbarItem(placement: .confirmationAction) {
                            
                            
                            if newRecipe.isValid {
                                Button("Add") {
                                    recipeDataVM.add(recipe: newRecipe)
                                    newRecipe = Recipe()
                                    isPresenting.toggle()
                                }
                            }
                        }
                    }
                    .navigationTitle("Add a New Recipe")
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
        .foregroundStyle(Color.customForeground)
        .navigationDestination(for: Recipe.self) { recipe in
            RecipeDetailView(recipe: binding(for: recipe) )
        }
        .navigationTitle(navigationTitle)
    }
}


//MARK: - RecipeListView Extention

extension RecipesListView {
    
    var recipes: [Recipe] { recipeDataVM.recipes(for: category) }

    // navigation title could be add in a constant extructure
    var navigationTitle: String { "\(category.rawValue) Recipes" }
    
    func binding(for recipe: Recipe) -> Binding<Recipe> {
        
        @Bindable var vm = recipeDataVM
        
        guard let index = recipeDataVM.index(of: recipe) else {
            fatalError("Recipe not found")
        }
        return $vm.recipes[index]
    }
  
}

//MARK: - preview

#Preview {
    NavigationStack {
        RecipesListView(category: .breakfast)
            .environment(RecipeData())
    }
}
