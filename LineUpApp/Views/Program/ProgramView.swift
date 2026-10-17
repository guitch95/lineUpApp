//
//  ProgrammeView.swift
//  LineUpApp
//
//  Created by Guillaume Richard on 16/10/2026.
//

import SwiftUI

struct ProgramView: View {
    let events = [
        (name: "Maîtrise de la voix", author: "Collectif La Voix Haute", start: "19h00", end: "20h30", place: "Cour des Célestins"),
        (name: "Improvisation Jazz", author: "Marcus Delacroix", start: "14h00", end: "16h00", place: "Scène Beckett"),
        (name: "Lecture perchée", author: "Isabelle Moreau", start: "13h30", end: "15h30", place: "Studio Artaud")
    ]
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 28) {
                    ScheduleHeaderView()
                    DatePillPicker()
                    
                    ForEach(events, id: \.name) { event in
                        EventRow(
                            workshopName: event.name,
                            authorName: event.author,
                            startTime: event.start,
                            endTime: event.end,
                            place: event.place
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
