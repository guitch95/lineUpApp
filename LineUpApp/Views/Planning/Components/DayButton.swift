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

    private var isSelected: Bool {
        Calendar.current.isDate(day, inSameDayAs: selectedDay)
    }

    var body: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.2)) {
                selectedDay = day
            }
        } label: {
            VStack(spacing: 4) {
                Text(day.formatted(.dateTime.weekday(.abbreviated)))
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Text(day.formatted(.dateTime.day()))
                    .font(.system(.title3, design: .serif, weight: .bold))
                    .foregroundStyle(isSelected ? Color.redBtn : Color.primary)

                Circle()
                    .fill(isSelected ? Color.redBtn : Color.gold)
                    .frame(width: 5, height: 5)
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
