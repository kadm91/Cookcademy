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
       NavigationStack {
           ScrollView {
               LazyVGrid(columns: layout ) {
               ForEach(MainInformation.Category.allCases,id: \.self) { category in
                   NavigationLink(value: category) {
                       CategoryView(category: category)
                   }
               }
             }
           }
           .navigationTitle(title)
           .navigationDestination(for: MainInformation.Category.self) { category in
               RecipesListView(category: category)
                   .environment(RecipeDataMV)
           }
           
       }
     }
    
    //MARK: - Init for styling
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .customForeground
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.cusumBackground], for: .selected)
        UISegmentedControl.appearance().backgroundColor = .cusumBackground
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.customForeground], for: .normal)
        
        UIStepper.appearance().backgroundColor = .cusumBackground
        UIStepper.appearance().setDecrementImage(UIImage(systemName: "minus")?.withTintColor(.accent), for: .normal)
        UIStepper.appearance().setIncrementImage(UIImage(systemName: "plus")?.withTintColor(.accent), for: .normal)
        
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.customForeground]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.customForeground]
        
        
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



