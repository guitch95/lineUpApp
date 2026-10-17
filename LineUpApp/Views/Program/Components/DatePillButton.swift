//
//  DatePillButton.swift
//  LineUpApp
//
//  Created by Canessane Ramya on 17/10/2026.
//

import SwiftUI

struct DatePillButton: View {
    @Binding var selectedDate: String
    let dateText: String
    
    var isSelected: Bool {
        selectedDate == dateText
    }
    
    var body: some View {
        Button {
            selectedDate = dateText
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
    DatePillButton(selectedDate: .constant("Ven 5"), dateText: "Ven 5")
}
