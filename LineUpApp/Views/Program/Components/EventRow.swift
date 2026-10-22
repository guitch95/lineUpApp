//
//  EventRow.swift
//  LineUpApp
//
//  Created by Canessane Ramya on 17/10/2026.
//

import SwiftUI

struct EventRow: View {
    let workshop: Workshop
    let authorName: String
    let place: String
    
    private func formatTime(_ date: Date) -> String {
        date.formatted(.dateTime.hour().minute().locale(Locale(identifier: "fr_FR")))
    }
    
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(.btnListeAttente)
                .frame(width: 68, height: 68)
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(workshop.name)
                        .font(.system(size: 14))
                        .fontWeight(.semibold)
                    Spacer()
                    CategoryTag(category: workshop.category.name)
                }
                
                Text(authorName)
                    .font(.system(size: 12))
                    .fontWeight(.regular)
                    .foregroundStyle(.fontGrayBtn)

                HStack(spacing: 0) {
                    Text("\(formatTime(workshop.startTime)) – \(formatTime(workshop.endTime))")
                    Text(" · \(place)")
                    Spacer()
                    AvailabilityBadge(
                        subscribersNb: workshop.subscribersNb,
                        capacityMax: workshop.capacityMax
                    )
                }
                .font(.system(size: 11))
                .fontWeight(.regular)
                .foregroundStyle(.btnListeAttente)
            }
        }
    }
}
#Preview {
    EventRow(
        workshop: Workshop(
            id: UUID(),
            name: "Maîtrise de la voix",
            startTime: Workshop.makeDate(hour: 19, minute: 0),
            endTime: Workshop.makeDate(hour: 20, minute: 30),
            capacityMax: 10,
            subscribersNb: 8,
            description: "Atelier vocal complet",
            category: Category(id: UUID(), name: "VOIX")
        ),
        authorName: "Collectif La Voix Haute",
        place: "Cour des Célestins"
    )
    .padding()
}
