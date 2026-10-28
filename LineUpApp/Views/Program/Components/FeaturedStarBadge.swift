//
//  FeaturedStarBadge.swift
//  LineUpApp
//
//  Created by Canessane Ramya on 28/10/2026.
//

import SwiftUI

struct FeaturedStarBadge: View {
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "star.fill")
                .font(.system(size: 12))
                .foregroundStyle(.white)
            
            Text("Atelier vedette")
                .textCase(.uppercase)
                .font(.system(size: 10, weight: .bold))
                .tracking(0.5)
                .foregroundStyle(.white)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .background(.redBtn)
        .clipShape(RoundedRectangle(cornerRadius: 5))
    }
}

#Preview {
    FeaturedStarBadge()
        .padding()
}
