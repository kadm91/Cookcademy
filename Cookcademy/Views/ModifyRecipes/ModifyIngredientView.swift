//
//  ModifyIngredientView.swift
//  Cookcademy
//
//  Created by Kevin Martinez on 1/4/24.
//

import SwiftUI

struct ModifyIngredientView: View {
    
    @State var ingredient: Ingredient
    
    var body: some View {
        Form {
            ingredientNameField
            quantityField
            unitField
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
}

//MARK: - Preview

#Preview {
    ModifyIngredientView(ingredient: Recipe.testRecipes[0].ingredients[0])
}


extension NumberFormatter {
    static var decimal: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }
}
