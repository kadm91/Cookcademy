//
//  ModifyRecipeView.swift
//  Cookcademy
//
//  Created by Kevin Martinez on 12/31/23.
//

import SwiftUI

struct ModifyRecipeView: View {

    @Binding var recipe: Recipe
    @State private var selection = Selection.main

    var body: some View {
        
        
        VStack {
            selectionView
            returnSelectionForm(from: selection)
            
            Spacer()
            
        }
        

    }
}

//MARK: - extension

extension ModifyRecipeView {
    
    var selectionView: some View {
        Picker("Selection", selection: $selection) {
            ForEach(Selection.allCases) {
                Text($0.rawValue.capitalized)
                    
            }
            
        }
        
        .pickerStyle(.segmented)
        .padding()
    }
    
    
    @ViewBuilder func returnSelectionForm(from selection: Selection ) -> some View {
        
        switch selection {
            
        case .main:
            ModifyMainInformationView(mainInformation: $recipe.mainInformation)
            
        case .ingredients:
            Text("Ingredients Selection")
            
        case .directions:
            Text("Directions Section")
        }
        
    }
    
    
    enum Selection: String, CaseIterable, Identifiable {
        case main, ingredients, directions
        var id: Self { self }
    }
    
}


//MARK: - Preview

#Preview {
    ModifyRecipeView(recipe: .constant(Recipe.testRecipes[0]))
}
