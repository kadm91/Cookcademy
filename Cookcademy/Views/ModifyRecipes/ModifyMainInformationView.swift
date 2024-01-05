//
//  ModifyMainInformationView.swift
//  Cookcademy
//
//  Created by Kevin Martinez on 1/4/24.
//

import SwiftUI

struct ModifyMainInformationView: View {
    
    @Binding var mainInformation: MainInformation
    
    var body: some View {
        
        Form {
            infoRow(for: "Recipe Name", text: $mainInformation.name)
            infoRow(for: "Author", text: $mainInformation.author)
            descriptionSection
            category
        }
    }
}

//MARK: - extension

extension ModifyMainInformationView {
    
    
   
    func infoRow (for title: String, text: Binding<String>) -> some View {
        
        LabeledContent {
            TextField(title, text: text)
                .multilineTextAlignment(.trailing)
        } label: {
            Text("\(title):")
                .bold()
        }
        .listRowBackground(Color.cusumBackground)
        .foregroundStyle(Color.customForeground)
    }
    
    var descriptionSection: some View {
        Section {
            TextEditor(text: $mainInformation.description)
                .frame(height: 100)
        } header: {
            Text("Description")
                .font(.subheadline)
                .bold()
        }
        .listRowBackground(Color.cusumBackground)
        .foregroundStyle(Color.customForeground)
    }
    
    var category: some View {
        
        
        Picker(selection: $mainInformation.category) {
            ForEach(MainInformation.Category.allCases) {
                Text($0.rawValue.capitalized)
            }
            
        } label: {
            Text("Category")
                .bold()
        }
        .listRowBackground(Color.cusumBackground)
        .tint(Color.customForeground)
        .foregroundStyle(Color.customForeground)
        .pickerStyle(.menu)

    }
 
    
}

//MARK: - Preview

#Preview {
    ModifyMainInformationView(mainInformation: .constant(Recipe.testRecipes[0].mainInformation))
}
