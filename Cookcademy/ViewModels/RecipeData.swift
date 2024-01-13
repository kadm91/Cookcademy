//
//  RecipeData.swift
//  Cookcademy
//
//  Created by Kevin Martinez on 12/29/23.
//

import Foundation

@Observable class RecipeData {
    var recipes = Recipe.testRecipes
    
    var favoriteRecipes: [Recipe] {
        recipes.filter{$0.isFavorite}
    }
    
    func recipes(for category: MainInformation.Category) -> [Recipe] {
        var filteredRecipes = [Recipe]()
        for recipe in recipes {
            if recipe.mainInformation.category == category {
                filteredRecipes.append(recipe)
            }
        }
        
        return filteredRecipes
    }
    
    func add(recipe: Recipe) {
        if recipe.isValid {
            recipes.append(recipe)
        }
    }
    
    func index(of recipe: Recipe) -> Int? {
        for i in recipes.indices {
            if recipes[i].id == recipe.id {
                return i
            }
        }
        return nil
    }
    
  
    
    
}
