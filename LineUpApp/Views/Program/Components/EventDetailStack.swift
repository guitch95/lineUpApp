//
//  EventDetailStack.swift
//  LineUpApp
//
//  Created by Canessane Ramya on 17/10/2026.
//

import SwiftUI

struct EventDetailStack: View {
    let workshopName: String
    let authorName: String
    let startTime: String
    let endTime: String
    let place: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(workshopName)
                .font(.system(size: 14))
                .fontWeight(.semibold)
            Text(authorName)
                .font(.system(size: 12))
                .fontWeight(.regular)
                .foregroundStyle(.fontGrayBtn)

            HStack(spacing: 0) {
                Text("\(startTime) - \(endTime)")
                Text(" · \(place)")
            }
            .font(.system(size: 11))
            .fontWeight(.regular)
            .foregroundStyle(.btnListeAttente)
        }
    }
}

#Preview {
    EventDetailStack(
        workshopName: "Maitrise de la voix",
        authorName: "Collectif La Voix Haute",
        startTime: "19h00",
        endTime: "20h00",
        place: "Cour des Célestins"
    )
}
