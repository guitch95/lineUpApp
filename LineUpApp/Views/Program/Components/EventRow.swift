//
//  EventRow.swift
//  LineUpApp
//
//  Created by Canessane Ramya on 17/10/2026.
//

import SwiftUI

struct EventRow: View {
    let workshopName: String
    let authorName: String
    let startTime: String
    let endTime: String
    let place: String
    
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(.btnListeAttente)
                .frame(width: 68, height: 68)
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(workshopName)
                        .font(.system(size: 14))
                        .fontWeight(.semibold)
                    Spacer()
                    CategoryTag(category: "voix")
                }
                
                Text(authorName)
                    .font(.system(size: 12))
                    .fontWeight(.regular)
                    .foregroundStyle(.fontGrayBtn)

                HStack(spacing: 0) {
                    Text("\(startTime) - \(endTime)")
                    Text(" · \(place)")
                    Spacer()
                    AvailabilityBadge(subscribersNb: 4, capacityMax: 5)
                }
                .font(.system(size: 11))
                .fontWeight(.regular)
                .foregroundStyle(.btnListeAttente)
            }
        }
    }
}

#Preview {
    EventRow(
        workshopName: "Maitrise de la voix",
        authorName: "Collectif La Voix Haute",
        startTime: "19h00",
        endTime: "20h00",
        place: "Cour des Célestins"
    )
    .padding()
}
