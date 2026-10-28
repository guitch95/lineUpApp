//
//  ScheduleHeaderView.swift
//  LineUpApp
//
//  Created by Canessane Ramya on 17/10/2026.
//

import SwiftUI

struct ScheduleHeaderView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("6 - 8 novembre · Lyon")
                .font(.system(size: 11))
                .textCase(.uppercase)
                .fontWeight(.medium)
                .foregroundStyle(.redBtn)
            Text("Programme")
                .font(.system(size: 26))
                .fontWeight(.bold)
                .fontDesign(.serif)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    ScheduleHeaderView()
}
