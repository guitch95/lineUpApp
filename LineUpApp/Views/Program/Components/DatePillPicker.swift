//
//  DatePillPicker.swift
//  LineUpApp
//
//  Created by Canessane Ramya on 17/10/2026.
//

import SwiftUI

struct DatePillPicker: View {
    let availableDays: [Date]
    @Binding var selectedDate: Date
    
    var body: some View {
        HStack() {
            ForEach(availableDays, id: \.self) { date in
                DatePillButton(selectedDate: $selectedDate, date: date)
            }
        }
    }
}

#Preview {
    let sampleDates = [
            Calendar.current.date(from: DateComponents(year: 2026, month: 9, day: 5)) ?? Date(),
            Calendar.current.date(from: DateComponents(year: 2026, month: 9, day: 6)) ?? Date(),
            Calendar.current.date(from: DateComponents(year: 2026, month: 9, day: 7)) ?? Date()
        ]
    
    DatePillPicker(availableDays: sampleDates, selectedDate: .constant(sampleDates[0]))
}
