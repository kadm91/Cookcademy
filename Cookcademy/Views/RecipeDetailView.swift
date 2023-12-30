//
//  RecipeDetailView.swift
//  Cookcademy
//
//  Created by Kevin Martinez on 12/29/23.
//

import SwiftUI

struct RecipeDetailView: View {
    
    let recipe: Recipe
    
    var body: some View {
        VStack {
           author
           description
            
            List {
                ingredientsSection
                directionSection
            }
         
            
            
            
            
        }
        .navigationTitle(title)
    }
}

//MARK: - RecipeDetailView extention

extension RecipeDetailView {
    
    var author: some View {
        HStack {
            Text("Author \(recipe.mainInformation.author)")
                .font(.subheadline)
                .padding()
            Spacer()
        }
    }
    
    var description: some View {
        HStack {
            Text(recipe.mainInformation.description)
                .font(.subheadline)
                .padding()
            Spacer()
        }
    }
    
    var title: String {
        recipe.mainInformation.name
    }
    
    var ingredients: [Ingredient] {recipe.ingredients }
    
    var directions: [Direction] { recipe.directions}
    
    var ingredientsSection: some View {
        Section("Ingredients") {
            ForEach(ingredients) { ingredient in
                Text(ingredient.description)
            }
        }
    }
    
    var directionSection: some View {
        Section("Directions") {
            ForEach (directions) { direction in
                let index =  recipe.directions.firstIndex {$0 == direction} ?? 0
                HStack {
                    Text("\(index + 1). ")
                    Text("\(direction.isOptional ? "(Optional) " : "")"
                                       + "\(direction.description)")
                }
            }
        }
    }

 
}

//MARK: - Preview

#Preview {
    NavigationStack {
        RecipeDetailView(recipe: Recipe.testRecipes[0])
    }
}
