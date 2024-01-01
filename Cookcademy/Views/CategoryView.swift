//
//  CategoryView.swift
//  Cookcademy
//
//  Created by Kevin Martinez on 12/31/23.
//

import SwiftUI

struct CategoryView: View {
    
    let category: MainInformation.Category
    
    var body: some View {
        ZStack {
            Image(category.rawValue)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .opacity(0.35)
            Text(category.rawValue)
                .font(.title)
                .bold()
                .foregroundStyle(.blue)
        }
    }
}

#Preview {
    CategoryView(category: MainInformation.Category.dessert)
}
