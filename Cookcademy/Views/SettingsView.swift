//
//  SettingsView.swift
//  Cookcademy
//
//  Created by Kevin Martinez on 1/13/24.
//

import SwiftUI

struct SettingsView: View {
  @State private var hideOptionalSteps: Bool = false
    @State private var listBackgroundColor = Color.cusumBackground
    @State private var listTextColor = Color.accentColor
  
  var body: some View {
    NavigationView {
      Form {
        ColorPicker("List BackgroundColor", selection: $listBackgroundColor)
          .padding()
          .listRowBackground(listBackgroundColor)
        ColorPicker("Text Color", selection: $listTextColor)
          .padding()
          .listRowBackground(listBackgroundColor)
        Toggle("Hide Optional Steps", isOn: $hideOptionalSteps)
          .padding()
          .listRowBackground(listBackgroundColor)
      }
      .foregroundColor(listTextColor)
      .navigationTitle("Settings")
    }
  }
}

#Preview {
    SettingsView()
}
