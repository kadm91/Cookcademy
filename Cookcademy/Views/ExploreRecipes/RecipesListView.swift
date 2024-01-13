//
//  RecipesListView.swift
//  Cookcademy
//
//  Created by Kevin Martinez on 12/26/23.
//

import SwiftUI

struct RecipesListView: View {
    
    @Environment(RecipeData.self) var recipeDataVM
    
    let viewStyle: ViewStyle
    
    @State private var isPresenting = false
    @State private var newRecipe = Recipe()
    
    var body: some View {
        
        List {
            ForEach(recipes) { recipe in
                NavigationLink(value: recipe) {
                    HStack {
                        Text(recipe.mainInformation.name)
                        Spacer()
                        if recipe.isFavorite {
                            Image(systemName: "star.fill")
                                .foregroundStyle(Color.yellow)
                                .padding(.trailing, 10)
                        }
                        
                    }
                  
                    
                        
                }
                .listRowBackground(Color.cusumBackground)
            }
        }
        .toolbar {
            ToolbarItem (placement: .topBarTrailing) {
                Button ("Add New Recipe", systemImage: "plus") {
                    isPresenting.toggle()
                    newRecipe = Recipe()
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
                            
                            
                            if newRecipe.isValid {
                            
                                Button("Add") {
                                    if case .favorites = viewStyle {
                                        newRecipe.isFavorite = true
                                    }
                                    recipeDataVM.add(recipe: newRecipe)
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
    
    var recipes: [Recipe] {
        
        switch viewStyle {
            
        case .favorites: return recipeDataVM.favoriteRecipes
 
        case let .singleCategory(category):
            return recipeDataVM.recipes(for: category)
        
        }
        
      
        
    }

    // navigation title could be add in a constant extructure
    var navigationTitle: String { 
        switch viewStyle {
            
        case .favorites:
            return "Favorite Recipes"
        case let .singleCategory(category):
          return  "\(category.rawValue) Recipes"
        }
        
        
       
    }
    
    func binding(for recipe: Recipe) -> Binding<Recipe> {
        
        @Bindable var vm = recipeDataVM
        
        guard let index = recipeDataVM.index(of: recipe) else {
            fatalError("Recipe not found")
        }
        return $vm.recipes[index]
    }
  
    
    enum ViewStyle {
        case favorites
        case singleCategory(MainInformation.Category)
    }
}

//MARK: - preview

#Preview ("Category Preview") {
    NavigationStack {
        RecipesListView(viewStyle: .singleCategory(.breakfast))
            .environment(RecipeData())
    }
}

#Preview ("Favorite List Preview") {
    NavigationStack {
        RecipesListView(viewStyle: .favorites)
            .environment(RecipeData())
    }
}
