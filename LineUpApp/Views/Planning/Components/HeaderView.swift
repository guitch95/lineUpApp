//
//  HeaderView.swift
//  LineUpApp
//
//  Created by Apprenant151 on 21/10/2026.
//

import SwiftUI

struct HeaderView: View {

    let reservedCount: Int

    private var reservedText: String {
        let plural = reservedCount > 1 ? "s" : ""
        return reservedCount > 0 ? "\(reservedCount) atelier\(plural) réservé\(plural) sur le festival" : "Aucun atelier réservé"
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Mon planning")
                .font(.system(.largeTitle, design: .serif, weight: .bold))

            Text(reservedText)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    HeaderView(reservedCount: 5)
}
