//
//  RecipeData.swift
//  Cookcademy
//
//  Created by Kevin Martinez on 12/29/23.
//

import Foundation

@Observable class RecipeData {
    var recipes = Recipe.testRecipes
    
    func recipes(for category: MainInformation.Category) -> [Recipe] {
        var filteredRecipes = [Recipe]()
        for recipe in recipes {
            if recipe.mainInformation.category == category {
                filteredRecipes.append(recipe)
            }
        }
        
        return filteredRecipes
    }
}
