//
//  Utilities.swift
//  Cookcademy
//
//  Created by Kevin Martinez on 1/8/24.
//

import Foundation

extension NumberFormatter {
    static var decimal: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }
}
