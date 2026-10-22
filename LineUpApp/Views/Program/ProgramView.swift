//
//  ProgrammeView.swift
//  LineUpApp
//
//  Created by Guillaume Richard on 16/10/2026.
//

import SwiftUI

struct ProgramView: View {
    let mocks = Workshop.mockList
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 28) {
                    ScheduleHeaderView()
                    DatePillPicker()
                    
                    ForEach(mocks, id: \.workshop.id) { mock in
                        EventRow(
                            workshop: mock.workshop,
                            authorName: mock.authorName,
                            place: mock.place
                        )
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
