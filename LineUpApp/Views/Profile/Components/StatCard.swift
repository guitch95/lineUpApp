//
//  StatCard.swift
//  LineUpApp
//
//  Created by Guillaume Richard on 30/10/2026.
//

import SwiftUI

struct StatCard: View {
    let title: String
    let value: Int

    var body: some View {
        HStack {
            Text(title)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
            Spacer()
            Text("\(value)")
                .font(.title)
                .fontWeight(.bold)
                .fontDesign(.serif)
                .foregroundStyle(.redBtn)
        }
        .padding(.horizontal, 16)
        .frame(height: 64)
        .background(.white, in: .rect(cornerRadius: 12))
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(.gray.opacity(0.15), lineWidth: 1)
        }
    }
}

#Preview {
    StatCard(title: "Ateliers réservés", value: 3)
        .padding()
}
