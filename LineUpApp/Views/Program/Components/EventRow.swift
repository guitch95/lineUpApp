//
//  EventRow.swift
//  LineUpApp
//
//  Created by Canessane Ramya on 17/10/2026.
//

import SwiftUI

struct EventRow: View {
    let workshop: Workshop
    
    private func formatTime(_ date: Date) -> String {
        date.formatted(.dateTime.hour().minute().locale(Locale(identifier: "fr_FR")))
    }
    
    func makeDate(hour: Int, minute: Int) -> Date {
            let calendar = Calendar.current
            return calendar.date(bySettingHour: hour, minute: minute, second: 0, of: Date()) ?? Date()
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
                
                Text(workshop.speaker ?? "")
                    .font(.system(size: 12))
                    .fontWeight(.regular)
                    .foregroundStyle(.fontGrayBtn)

                HStack(spacing: 0) {
                    Text("\(formatTime(workshop.startTime)) – \(formatTime(workshop.endTime))")
                    Text(" · \(String(describing: workshop.location))")
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
//    EventRow(
//        workshop: Workshop(
//            id: UUID(),
//            name: "Maîtrise de la voix",
//            startTime: Workshop.makeDate(hour: 19, minute: 0),
//            endTime: Workshop.makeDate(hour: 20, minute: 30),
//            capacityMax: 10,
//            subscribersNb: 8,
//            description: "Atelier vocal complet",
//            category: Category(id: UUID(), name: "VOIX"),
//            location: "Cour des Célestins",
//            speaker: "Collectif La Voix Haute"
//        ),
//        
//    )
//    .padding()
}
