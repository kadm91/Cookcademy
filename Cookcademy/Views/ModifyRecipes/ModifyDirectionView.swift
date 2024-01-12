//
//  ModifyDirectionView.swift
//  Cookcademy
//
//  Created by Kevin Martinez on 1/8/24.
//

import SwiftUI

struct ModifyDirectionView: ModifyComponentView {
    
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
        .foregroundStyle(.customForeground)
        .listRowBackground(Color.cusumBackground)
    }
    
    var optionalField: some View {
        Toggle(isOn: $direction.isOptional) {
            Text("Optional").bold()
        }
        .tint(.accent)
        .foregroundStyle(.accent)
        .listRowBackground(Color.cusumBackground)
    }
    
    var saveBtn: some View {
        
        Section {
            Button {
                createAction(direction)
                dismiss()
            } label: {
                Text("Save")
                    .font(.title3)
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: .infinity)
                    .bold()
            }
            .tint(.accent)
            .buttonStyle(.bordered)
            .listRowBackground(Color.clear)
        }
    }
}

//MARK: - Preview

#Preview {
    ModifyDirectionView(component: .constant(Direction())) { print($0) }
}
