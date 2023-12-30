//
//  RecipesListView.swift
//  Cookcademy
//
//  Created by Kevin Martinez on 12/26/23.
//

import SwiftUI

struct RecipesListView: View {
    
    @Environment(RecipeData.self) var recipeDataVM
    
    
    var body: some View {
        List {
            ForEach(recipes) { recipe in
                Text(recipe.mainInformation.name)
            }
        }
        .navigationTitle(navigationTitle)
    }
}


//MARK: - RecipeListView Extention

extension RecipesListView {
    
    var recipes: [Recipe] { recipeDataVM.recipes }

    // navigation title could be add in a constant extructure
    var navigationTitle: String { "All Recipes" }
}

//MARK: - preview

#Preview {
    NavigationStack {
        RecipesListView()
            .environment(RecipeData())
    }
}
