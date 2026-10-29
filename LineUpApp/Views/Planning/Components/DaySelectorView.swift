//
//  DaySelectorView.swift
//  LineUpApp
//
//  Created by Apprenant151 on 22/10/2026.
//

import SwiftUI

struct DaySelectorView: View {
    let days: [Date]
    let reservedDays: Set<Date>
    @Binding var selectedDay: Date

    var body: some View {
        HStack(spacing: 2) {
            ForEach(days, id: \.self) { day in
                DayButton(
                    day: day,
                    hasReservation: reservedDays.contains(day),
                    selectedDay: $selectedDay
                )
            }
        }
        .padding(6)
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(Color.primary.opacity(0.06))
        )
    }
}

#Preview {
    let today = Calendar.current.startOfDay(for: Date())
    let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)!
    DaySelectorView(
        days: [today, tomorrow],
        reservedDays: [tomorrow],
        selectedDay: .constant(today)
    )
}
