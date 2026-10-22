//
//  ProgrammeView.swift
//  LineUpApp
//
//  Created by Guillaume Richard on 16/10/2026.
//

import SwiftUI

struct ProgramView: View {
    let mocks = Workshop.samples
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 28) {
                    ScheduleHeaderView()
                    DatePillPicker()
                    
                    ForEach(mocks) { mock in
                        EventRow(workshop: mock)
                        Divider()
                    }
                }
                .padding()
            }
            .background(.bg)
        }
    }
}

#Preview {
    ProgramView()
}
