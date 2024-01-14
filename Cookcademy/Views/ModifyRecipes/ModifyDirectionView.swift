//
//  ModifyDirectionView.swift
//  Cookcademy
//
//  Created by Kevin Martinez on 1/8/24.
//

import SwiftUI

struct ModifyDirectionView: ModifyComponentView {
    @AppStorage ("mainColor")private var mainColor = Color.accentColor
    
    @Environment (\.dismiss) var dismiss
    
    @Binding var direction: Direction
    let createAction: ((Direction) -> Void)
    
    init(component: Binding<Direction>, createAction: @escaping (Direction) -> Void) {
        self._direction = component
        self.createAction = createAction
    }
    
    var body: some View {
        Form {
            directionInstructionsField
            optionalField
            saveBtn
        }
        .tint(mainColor)
    }
}

//MARK: - extension

extension ModifyDirectionView {
    
    var directionInstructionsField: some View {
        LabeledContent {
            TextField("DirectionDescription", text: $direction.description)
                .multilineTextAlignment(.trailing)
        } label: {
            Text("Direction:").bold()
        }
        .foregroundStyle(Color.accentColor)
       // .listRowBackground(Color.cusumBackground)
    }
    
    var optionalField: some View {
        Toggle(isOn: $direction.isOptional) {
            Text("Optional").bold()
        }
        .tint(Color.accentColor)
        .foregroundStyle(Color.accentColor)
        // .listRowBackground(Color.cusumBackground)
    }
    
    var saveBtn: some View {
        
        ComponentSaveBtn {
            createAction(direction)
            dismiss()
        }
        .disabled(direction.description == "" ? true : false)
        .foregroundStyle(direction.description == "" ? .gray : Color.accentColor)
        .tint(direction.description == "" ? .gray : Color.accentColor)
    }
}

//MARK: - Preview

#Preview ("New Direction") {
    ModifyDirectionView(component: .constant(Direction())) { print($0) }
}

#Preview ("Edit Direction") {
    ModifyDirectionView(component: .constant(Recipe.testRecipes[1].directions[1])) { print($0) }
}
