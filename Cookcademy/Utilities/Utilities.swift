//
//  Utilities.swift
//  Cookcademy
//
//  Created by Kevin Martinez on 1/8/24.
//

import SwiftUI

extension NumberFormatter {
    static var decimal: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }
}


struct ComponentSaveBtn: View {
    
    
    var action: () -> Void
    
    var body: some View {
        Section {
            Button {
                action()
            } label: {
                 Text("Save")
                    .font(.title3)
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: .infinity)
                    .bold()
            }
            .listRowBackground(Color.clear)
            .buttonStyle(.bordered)
        }

    }
}
