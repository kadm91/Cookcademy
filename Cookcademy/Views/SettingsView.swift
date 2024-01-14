//
//  SettingsView.swift
//  Cookcademy
//
//  Created by Kevin Martinez on 1/13/24.
//

import SwiftUI

struct SettingsView: View {
  @State private var hideOptionalSteps: Bool = false
    @AppStorage ("mainColor")private var mainColor = Color.accentColor
  
  var body: some View {
    NavigationView {
      Form {
          ColorPicker("Accent Color", selection: $mainColor)
          .padding()
          //.listRowBackground(Color.cusumBackground)
    
        Toggle("Hide Optional Steps", isOn: $hideOptionalSteps)
          .padding()
          //.listRowBackground(Color.cusumBackground)
          .tint(mainColor)
      }
      .foregroundColor(mainColor)
      .navigationTitle("Settings")
    }
  }
}

#Preview {
    SettingsView()
}
