//
//  DatePillPicker.swift
//  LineUpApp
//
//  Created by Canessane Ramya on 17/10/2026.
//

import SwiftUI

struct DatePillPicker: View {
    let dates: [String] = ["Ven 5", "Sam 6", "Dim 7"]
    @State private var selectedDate = "Ven 5"
    
    var body: some View {
        HStack() {
            ForEach(dates, id: \.self) { date in
                DatePillButton(selectedDate: $selectedDate, dateText: date)
            }
        }
    }
}

#Preview {
    DatePillPicker()
}
