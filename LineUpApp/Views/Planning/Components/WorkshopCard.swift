//
//  WorkshopCard.swift
//  LineUpApp
//
//  Created by Apprenant151 on 22/10/2026.
//

import SwiftUI

struct WorkshopCard: View {
    let workshop: Workshop

    private var timeRange: String {
        "\(workshop.startTime.formatted(date: .omitted, time: .shortened)) - \(workshop.endTime.formatted(date: .omitted, time: .shortened))"
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(workshop.name)
                .font(.headline)

            Text(timeRange)
                .font(.subheadline)

            Label(workshop.category.name, systemImage: "mappin.and.ellipse")
                .font(.subheadline)
        }
        .foregroundStyle(.white)
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(Color.redBtn)
        )
    }
}

#Preview {
    WorkshopCard(
        workshop: Workshop(
            id: UUID(),
            name: "Jeu masqué",
            startTime: Date(),
            endTime: Date().addingTimeInterval(7200),
            capacityMax: 20,
            subscribersNb: 15,
            description: "",
            category: Category(id: UUID(), name: "Atelier Expression", workshops: [])
        )
    )
    .padding()
}
