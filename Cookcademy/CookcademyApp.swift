//
//  CookcademyApp.swift
//  Cookcademy
//
//  Created by Kevin Martinez on 12/26/23.
//

import SwiftUI

@main
struct CookcademyApp: App {
    
    @AppStorage ("mainColor")private var mainColor = Color.accentColor
    
    @State var recipeData = RecipeData()
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environment(recipeData)
                .accentColor(mainColor)
        }
        
    }
    

    
    
    
    
}
