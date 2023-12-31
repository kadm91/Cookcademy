//
//  RecipeCategoryGridView.swift
//  Cookcademy
//
//  Created by Kevin Martinez on 12/31/23.
//

import SwiftUI

struct RecipeCategoryGridView: View {
    
    @Environment(RecipeData.self) var RecipeDataMV
    
    var body: some View {
       NavigationView {
         LazyVGrid(columns: [GridItem()]) {
           ForEach(MainInformation.Category.allCases,
                   id: \.self) { category in
               Text(category.rawValue).font(.title)
           }
         }
         .navigationTitle(title)
       }
     }
   }

//MARK: - RecipeCategoryGridView Extension
 
extension RecipeCategoryGridView {
    var title: String { "Category" }
}

//MARK: - Preview

#Preview {
    RecipeCategoryGridView()
        .environment(RecipeData())
}
