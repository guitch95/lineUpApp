//
//  AvailabilityBadge.swift
//  LineUpApp
//
//  Created by Canessane Ramya on 17/10/2026.
//

import SwiftUI

struct AvailabilityBadge: View {
    var subscribersNb: Int
    var capacityMax: Int
    
    var isComplete: Bool {
        subscribersNb == capacityMax
    }
    var remainingPlaces: Int {
        capacityMax - subscribersNb
    }
    
    private var badgeText: String {
        if isComplete {
            return "Complet"
        } else if remainingPlaces == 1 {
            return "1 place"
        } else {
            return "\(remainingPlaces) places"
        }
    }
    
    private var badgeColor: Color {
        isComplete ? .btnListeAttente : .availableGreen
    }
    
    var body: some View {
        Text(badgeText)
            .font(.system(size: 11))
            .fontWeight(.medium)
            .foregroundStyle(badgeColor)
    }
}

#Preview {
    AvailabilityBadge(subscribersNb: 4, capacityMax: 5)
}
