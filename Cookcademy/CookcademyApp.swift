//
//  CookcademyApp.swift
//  Cookcademy
//
//  Created by Kevin Martinez on 12/26/23.
//

import SwiftUI

@main
struct CookcademyApp: App {
    
    @State var recipeData = RecipeData()
    
    var body: some Scene {
        WindowGroup {
            RecipeCategoryGridView()
                .environment(recipeData)
        }
    }
}
