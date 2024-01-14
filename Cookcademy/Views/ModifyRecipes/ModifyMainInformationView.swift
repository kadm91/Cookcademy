//
//  ModifyMainInformationView.swift
//  Cookcademy
//
//  Created by Kevin Martinez on 1/4/24.
//

import SwiftUI

struct ModifyMainInformationView: View {
    
    @AppStorage ("mainColor")private var mainColor = Color.accentColor
    
    @Binding var mainInformation: MainInformation
    
    var body: some View {
        
        Form {
            infoRow(for: "Recipe Name", text: $mainInformation.name)
            infoRow(for: "Author", text: $mainInformation.author)
            descriptionSection
            category
        }
        .tint(mainColor)
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
        //.listRowBackground(Color.cusumBackground)
        .foregroundStyle(mainColor)
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
        //.listRowBackground(Color.cusumBackground)
        .foregroundStyle(mainColor)
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
       // .listRowBackground(Color.cusumBackground)
        .tint(mainColor)
        .foregroundStyle(mainColor)
        .pickerStyle(.menu)

    }
 
    
}

//MARK: - Preview

#Preview {
    ModifyMainInformationView(mainInformation: .constant(Recipe.testRecipes[0].mainInformation))
}
