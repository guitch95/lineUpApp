//
//  HeaderView.swift
//  LineUpApp
//
//  Created by Apprenant151 on 21/10/2026.
//

import SwiftUI

struct HeaderView: View {
    
    let reservedCount: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Mon planning")
                .font(.system(.largeTitle, design: .serif, weight: .bold))

            Text("\(reservedCount) ateliers réservés sur le festival")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    HeaderView(reservedCount: 5)
}
