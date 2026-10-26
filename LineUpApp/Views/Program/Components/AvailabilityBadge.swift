//
//  AvailabilityBadge.swift
//  LineUpApp
//
//  Created by Canessane Ramya on 17/10/2026.
//

import SwiftUI

struct AvailabilityBadge: View {
    let workshop: Workshop
    
    var body: some View {
        Text(workshop.badgeText)
            .font(.system(size: 11))
            .fontWeight(.medium)
            .foregroundStyle(workshop.badgeColor)
    }
}

#Preview {
    AvailabilityBadge(workshop: Workshop.samples[0])
}
