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
            RecipesListView(viewStyle: .favorites)
        }.tabItem { Label("Favorites", systemImage: "heart.fill") }
          
          SettingsView()
              .tabItem { Label("Settings", systemImage: "gear")  }
      }
        
    }
    
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .customForeground
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.cusumBackground], for: .selected)
        UISegmentedControl.appearance().backgroundColor = .cusumBackground
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.customForeground], for: .normal)
        
        
        UIStepper.appearance().backgroundColor = .cusumBackground
        UIStepper.appearance().setDecrementImage(UIImage(systemName: "minus")?.withTintColor(.accent), for: .normal)
        UIStepper.appearance().setIncrementImage(UIImage(systemName: "plus")?.withTintColor(.accent), for: .normal)
        
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.customForeground, .font: UIFont(name: "Georgia-Bold", size: 30) as Any]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.customForeground]
        
        
    }
    
    
    
    
    
}

#Preview {
 
        MainTabView()
            .environment(RecipeData())
    
}
