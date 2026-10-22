//
//  DaySelectorView.swift
//  LineUpApp
//
//  Created by Apprenant151 on 22/10/2026.
//

import SwiftUI

struct DaySelectorView: View {
    let days: [Date]
    @Binding var selectedDay: Date

    var body: some View {
        HStack(spacing: 4) {
            ForEach(days, id: \.self) { day in
                DayButton(day: day, isSelected: day == selectedDay) {
                    selectedDay = day
                }
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
    DaySelectorView(days: [Date()], selectedDay: .constant(Date()))
}
