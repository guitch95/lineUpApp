//
//  WorkshopListView.swift
//  LineUpApp
//
//  Created by Apprenant151 on 22/10/2026.
//

import SwiftUI

struct WorkshopEmptyListView: View {
    let workshops: [Workshop]

    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                ForEach(workshops) { workshop in
                    WorkshopCard(workshop: workshop)
                }

                if workshops.isEmpty {
                    Text("Aucun atelier réservé ce jour-là")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .padding(.top, 40)
                }
            }
        }
    }
}

#Preview {
    WorkshopEmptyListView(workshops: [])
}
