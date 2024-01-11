//
//  RecipeDetailView.swift
//  Cookcademy
//
//  Created by Kevin Martinez on 12/29/23.
//

import SwiftUI

struct RecipeDetailView: View {
    
   @Binding var recipe: Recipe
   @State var isPresenting = false
    
    var body: some View {
        VStack {
            author
            description
            
            List {
                Group {
                    
                    ingredientsSection
                    directionSection
                }
                .listRowBackground(Color.cusumBackground)
                .foregroundStyle(Color.customForeground)
                
            }
            
        }
        .navigationTitle(title)
        .toolbar {
            ToolbarItem {
                Button("Edit") { isPresenting.toggle() }
            }
        }
        .sheet(isPresented: $isPresenting) {
            NavigationView {
                ModifyRecipeView(recipe: $recipe)
                    .toolbar {
                        ToolbarItem (placement: .confirmationAction) {
                            Button("Save") { isPresenting.toggle() }
                        }
                    }
            }
        }
    }
}

//MARK: - RecipeDetailView extention

extension RecipeDetailView {
    
    var author: some View {
        
        HStack {
            Group{
                Text("Author:")
                    .padding(.horizontal)
                    .bold()
                Text(recipe.mainInformation.author)
            }
                .padding(.top)
                .font(.subheadline)
                .foregroundStyle(.accent)
                
            Spacer()
        }
    }
    
    var description: some View {
        HStack {
            Text(recipe.mainInformation.description)
                .foregroundStyle(.accent)
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
        Section {
            ForEach(ingredients) { ingredient in
                Text(ingredient.description)
            }
        } header: {
            HStack {
                Spacer()
                Text("Ingredients")
                   .font(.title3)
                   .bold()
               .underline()
                Spacer()
            }
            .padding(.bottom, 5)
        }
    }
    
    var directionSection: some View {
        Section {
            ForEach (directions) { direction in
                let index =  recipe.directions.firstIndex {$0 == direction} ?? 0
                HStack {
                    Text("\(index + 1). ").bold()
                    Text("\(direction.isOptional ? "(Optional) " : "")"
                         + "\(direction.description)")
                }
            }
        } header: {
            HStack {
                Spacer()
                Text("Directions")
                   .font(.title3)
                   .bold()
               .underline()
                Spacer()
            }
            .padding(.bottom, 5)
               
        }
    }
    
    
}

//MARK: - Preview

#Preview {
    NavigationStack {
        RecipeDetailView(recipe: .constant(Recipe.testRecipes[0]))
    }
}
