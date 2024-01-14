//
//  RecipeDetailView.swift
//  Cookcademy
//
//  Created by Kevin Martinez on 12/29/23.
//

import SwiftUI

struct RecipeDetailView: View {
    
   @Binding var recipe: Recipe
   @State private var isPresenting = false
   @AppStorage ("mainColor")private var mainColor = Color.accentColor
    
    var body: some View {
        VStack {
            
                    author
                    description
       
            List {
                Group {
                    
                    ingredientsSection
                    directionSection
                }
                //.listRowBackground(Color.cusumBackground)
                .foregroundStyle(Color.accentColor)
                
            }
            
        }
        .navigationTitle(title)
        .toolbar {
            ToolbarItem {
              editBtn
            }
            
            ToolbarItem {
             favorityBtn
            }
        }
        .sheet(isPresented: $isPresenting) {
            NavigationStack {
                
                
                Group {
                    ModifyRecipeView(recipe: $recipe)
                    
                        .toolbar {
                            ToolbarItem (placement: .confirmationAction) {
                                Button("Save") { isPresenting.toggle() }
                            }
                            
                            ToolbarItem (placement: .cancellationAction) {
                                Button ("Dismiss") {
                                    isPresenting.toggle()
                                }
                            }
                        }
                        .navigationTitle("Edit Recipe")
                        .navigationBarTitleDisplayMode(.inline)
                }
                .tint(mainColor)
                .foregroundStyle(mainColor)
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
                .foregroundStyle(Color.accentColor)
                
            Spacer()
        }
    }
    
    var description: some View {
        HStack {
            Text(recipe.mainInformation.description)
                .foregroundStyle(Color.accentColor)
                .font(.subheadline)
                .padding()
            Spacer()
        }
    }
    
    var editBtn: some View {
        Button { isPresenting.toggle() } label: {
            Text("Edit").bold().font(.headline)
        }
    }
    
    var favorityBtn: some View {
        
        Button {
            withAnimation {
              recipe.isFavorite.toggle()
            }
         
        } label: {
            Image(systemName: recipe.isFavorite ? "star.fill" : "star")
                .font(.headline).bold()
        }
        .tint(.yellow)
        
        
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
