//
//  MainTabView.swift
//  Cookcademy
//
//  Created by Kevin Martinez on 1/12/24.
//

import SwiftUI

struct MainTabView: View {
    
    @AppStorage ("mainColor")private var mainColor = Color.accentColor
    
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
      .onAppear {
          RecipeDataMV.loadRecipes()
      }
        
    }
    
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(mainColor)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(.white)], for: .selected)
       // UISegmentedControl.appearance().backgroundColor = .cusumBackground
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(mainColor)], for: .normal)
        
        
       // UIStepper.appearance().backgroundColor = .cusumBackground
        UIStepper.appearance().setDecrementImage(UIImage(systemName: "minus")?.withTintColor(UIColor(mainColor)), for: .normal)
        UIStepper.appearance().setIncrementImage(UIImage(systemName: "plus")?.withTintColor(UIColor(mainColor)), for: .normal)
        
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(mainColor), .font: UIFont(name: "Georgia-Bold", size: 30) as Any]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(mainColor)]
        
        
    }
    
    
    
    
    
}

#Preview {
 
        MainTabView()
            .environment(RecipeData())
    
}
