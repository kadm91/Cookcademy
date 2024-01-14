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
                .opacity(0.25)
                .background(.thinMaterial)
               
            Text(category.rawValue)
                .font(.title2)
                .underline()
                .fontWeight(.heavy)
                .foregroundStyle(Color.accentColor)
                
        }
        .clipShape(RoundedRectangle(cornerRadius: 25.0))
        .overlay(RoundedRectangle(cornerRadius: 25.0).strokeBorder(Color.accentColor, lineWidth: 2))
        
        
    }
}

#Preview {
    CategoryView(category: MainInformation.Category.dessert)
        .padding()
}
