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


extension Color: RawRepresentable {
  public init?(rawValue: String) {
    do {
      let encodedData = rawValue.data(using: .utf8)!
      let components = try JSONDecoder().decode([Double].self, from: encodedData)
      self = Color(red: components[0],
                   green: components[1],
                   blue: components[2],
                   opacity: components[3])
    }
    catch {
      return nil
    }
  }
  
  public var rawValue: String {
    guard let cgFloatComponents = UIColor(self).cgColor.components else { return "" }
    let doubleComponents = cgFloatComponents.map { Double($0) }
    do {
      let encodedComponents = try JSONEncoder().encode(doubleComponents)
      return String(data: encodedComponents, encoding: .utf8) ?? ""
    }
    catch {
      return ""
    }
  }
}
