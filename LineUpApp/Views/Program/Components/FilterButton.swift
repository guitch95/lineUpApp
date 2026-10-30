//
//  FilterButton.swift
//  LineUpApp
//
//  Created by Canessane Ramya on 26/10/2026.
//

import SwiftUI

struct FilterButton: View {
    let categories: [String]
    @Binding var selectedCategory: String?
    
    var body: some View {
        Menu {
            // "Tous" (nil) : aucune catégorie sélectionnée
            Button {
                selectedCategory = nil
            } label: {
                Text("Tous")
                if selectedCategory == nil {
                    Image(systemName: "checkmark")
                }
            }

            ForEach(categories, id: \.self) { category in
                Button {
                    selectedCategory = category
                } label: {
                    Text(category)
                    if selectedCategory == category {
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
    FilterButton(categories: ["Danse", "Théâtre", "Voix"], selectedCategory: .constant(nil))
}
