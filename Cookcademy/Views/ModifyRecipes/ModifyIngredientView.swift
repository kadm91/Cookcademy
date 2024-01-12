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
    
   // make saveBtn a utility View to replace here and in the ModifyDirectionView, will do it with generics since componets comform to the same protocol
    
    var saveBtn: some View {
        
        ComponentSaveBtn {
            createAction(ingredient)
            dismiss()
        }
        .disabled(ingredient.name == "" ? true : false)
        .foregroundStyle(ingredient.name == "" ? .gray : .accent)
        .tint(ingredient.name == "" ? .gray : .accent)
        
    }
}

//MARK: - Preview

#Preview ("New Ingredient") {
    NavigationStack {
        ModifyIngredientView(
            component: .constant(Ingredient())) { print($0) }
    }
}

#Preview ("Edit Ingredient") {
    NavigationStack {
        ModifyIngredientView(
            component: .constant(Recipe.testRecipes[0].ingredients[0])) { print($0) }
    }
}




