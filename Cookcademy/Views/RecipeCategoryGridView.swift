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
           ScrollView {
               LazyVGrid(columns: layout ) {
               ForEach(MainInformation.Category.allCases,id: \.self) { category in
                   CategoryView(category: category)
               }
             }
               .navigationTitle(title)
           }
       }
     }
   }

//MARK: - RecipeCategoryGridView Extension
 
extension RecipeCategoryGridView {
    var title: String { "Category" }
    private var layout: [GridItem] { [GridItem(), GridItem()] }
}




//MARK: - Preview

#Preview {
    RecipeCategoryGridView()
        .environment(RecipeData())
}



