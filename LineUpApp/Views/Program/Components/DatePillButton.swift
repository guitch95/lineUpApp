//
//  DatePillButton.swift
//  LineUpApp
//
//  Created by Canessane Ramya on 17/10/2026.
//

import SwiftUI

struct DatePillButton: View {
    @Binding var selectedDate: Date
    let date: Date
    
    private var dateText: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.dateFormat = "EEE d" // Ven 5
        return formatter.string(from: date).capitalized // première lettre en majuscule
    }
    var isSelected: Bool {
        Calendar.current.isDate(date, inSameDayAs: selectedDate)
    }
    
    var body: some View {
        Button {
            selectedDate = date
        } label: {
            Text(dateText)
                .font(.system(size: 13))
                .fontWeight(.medium)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? .redBtn : .bgColorBtn)
                .foregroundStyle(isSelected ? .white : .fontGrayBtn)
                .clipShape(Capsule())
        }
    }
}

#Preview {
    let sampleDate = Calendar.current.date(from: DateComponents(year: 2026, month: 9, day: 5)) ?? Date()
    DatePillButton(selectedDate: .constant(sampleDate), date: sampleDate)
}
