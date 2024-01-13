//
//  MainTabView.swift
//  Cookcademy
//
//  Created by Kevin Martinez on 1/12/24.
//

import SwiftUI

struct MainTabView: View {
    @Environment(RecipeData.self) var RecipeDataMV
    
    var body: some View {
      TabView {
        RecipeCategoryGridView()
          .tabItem { Label("Recipes", systemImage: "list.dash") }
        NavigationStack {
          RecipesListView(category: .breakfast)
        }.tabItem { Label("Favorites", systemImage: "heart.fill") }
      }
    }
}

#Preview {
 
        MainTabView()
            .environment(RecipeData())
    
}
