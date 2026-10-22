//
//  DayButton.swift
//  LineUpApp
//
//  Created by Apprenant151 on 22/10/2026.
//

import SwiftUI


struct DayButton: View {
    let day: Date
    @Binding var selectedDay: Date

    private var isSelected: Bool { day == selectedDay }

    var body: some View {
        Button {
            selectedDay = day
        } label: {
            VStack(spacing: 6) {
                Text(day.formatted(.dateTime.weekday(.abbreviated)))
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Text(day.formatted(.dateTime.day()))
                    .font(.system(.title3, design: .serif, weight: .bold))
                    .foregroundStyle(isSelected ? Color.redBtn : Color.primary)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(isSelected ? Color.white : Color.clear)
            )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    DayButton(day: Date(), selectedDay: .constant(Date()))
}
