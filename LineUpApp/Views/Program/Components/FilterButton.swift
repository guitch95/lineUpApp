//
//  FilterButton.swift
//  LineUpApp
//
//  Created by Canessane Ramya on 26/10/2026.
//

import SwiftUI

struct FilterButton: View {
    let categories = WorkshopCategory.allCases
    @Binding var selectedCategory: String?
    
    var body: some View {
        Menu {
            ForEach(categories, id: \.self) { category in
                Button {
                    selectedCategory = (category == .all) ? nil : category.rawValue
                } label: {
                    Text(category.rawValue)
                    
                    // vérifie si la catégorie correspond ou si on est sur "Tous" (nil)
                    let isSelected = (selectedCategory == category.rawValue) || (selectedCategory == nil && category == .all)
                    
                    if isSelected {
                        Image(systemName: "checkmark")
                    }
                }
            }
        } label: {
            Image(systemName: "line.3.horizontal.decrease")
            Text("Filtrer")
                .font(.system(size: 12, weight: .medium))
        }
        .foregroundStyle(.primary)
        .font(.system(size: 13))
        .fontWeight(.medium)
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(Color.white)
        .clipShape(Capsule())
        .overlay {
            Capsule()
                .stroke(Color.gray.opacity(0.15), lineWidth: 1)
        }
    }
}

#Preview {
    FilterButton(selectedCategory: .constant("Tous"))
}
