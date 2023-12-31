//
//  ModifyIngredientView.swift
//  Cookcademy
//
//  Created by Kevin Martinez on 1/4/24.
//

import SwiftUI

struct ModifyIngredientView: ModifyComponentView {
    
    @Environment (\.dismiss) var dismiss
    
    @Binding var ingredient: Ingredient
    let createAction: ((Ingredient) -> Void)
    
    
    init(component: Binding<Ingredient>, createAction: @escaping (Ingredient) -> Void) {
        self._ingredient = component
        self.createAction = createAction
    }
    
    var body: some View {
        Form {
            ingredientNameField
            quantityField
            unitField
            saveBtn
        }
        .navigationTitle("Add Ingredient")
        .navigationBarTitleDisplayMode(.inline)
    }
}


//MARK: - extention

extension ModifyIngredientView {
    
    var ingredientNameField: some View {
        
        LabeledContent {
            TextField("Ingredient Name", text: $ingredient.name)
                .multilineTextAlignment(.trailing)
        } label: {
            Text("Ingredient Name:")
               
                .bold()
        }
        .foregroundStyle(.customForeground)

    }
    
    var quantityField: some View {
        Stepper(value: $ingredient.quantity, in: 0...100, step: 0.5) {
            
            LabeledContent {
                TextField("Quantity", value: $ingredient.quantity, formatter: NumberFormatter.decimal )
                    .keyboardType(.decimalPad)
                
            } label: {
                
                Text("Quantity:")
                    .padding(.trailing)
                    .bold()
            }
            .foregroundStyle(.customForeground)
        }
    }
    
    var unitField: some View {
        Picker(selection: $ingredient.unit) {
            ForEach(Ingredient.Unit.allCases) {
                Text($0.rawValue)
            }
        } label: {
            Text("Unit:")
                .foregroundStyle(.customForeground)
                .bold()
        }
        .tint(.customForeground)

    }
    
    var saveBtn: some View {
        Section {
            Button {
                createAction(ingredient)
                dismiss()
            } label: {
                 Text("Save")
                    .font(.title3)
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: .infinity)
                    .bold()
            }
            .listRowBackground(Color.clear)
            .tint(.accent)
            .buttonStyle(.bordered)
        }
    }
}

//MARK: - Preview

#Preview {
    NavigationStack {
        ModifyIngredientView(
            component: .constant(Ingredient())) { print($0) }
    }
}




