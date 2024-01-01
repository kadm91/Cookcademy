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
    
    var body: some View {
        List {
            ForEach(recipes) { recipe in
                NavigationLink(value: recipe) {
                    Text(recipe.mainInformation.name)
                        
                }
                .listRowBackground(Color.cusumBackground)
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
