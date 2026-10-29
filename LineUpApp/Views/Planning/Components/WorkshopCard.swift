//
//  WorkshopCard.swift
//  LineUpApp
//
//  Created by Apprenant151 on 22/10/2026.
//

import SwiftUI

struct WorkshopCard: View {
    let reservation: ReservationResponse

    private var timeRange: String {
        "\(hourLabel(reservation.startTimeWorkshop)) – \(hourLabel(reservation.endTimeWorkshop))"
    }

    private func hourLabel(_ date: Date) -> String {
        let time = Calendar.current.dateComponents(
            [.hour, .minute],
            from: date
        )
        return String(format: "%dh%02d", time.hour ?? 0, time.minute ?? 0)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(reservation.nameWorkshop)
                .font(.subheadline.weight(.semibold))
                .lineLimit(2)

            Text(timeRange)
                .font(.caption)
                .opacity(0.85)
                .lineLimit(1)

            Text("📍 \(reservation.location)")
                .font(.caption)
                .opacity(0.7)
                .lineLimit(1)
        }
        .foregroundStyle(.white)
        .padding(.horizontal, 12)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(.redBtn)
        )
        .padding(.leading, 3)
        .background(  // filet doré à gauche qui suit l'arrondi de la carte
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(Color.gold)
        )
    }
}

#Preview {
    WorkshopCard(reservation: ReservationResponse.samples[0])
        .frame(height: 104)
        .padding()
}
