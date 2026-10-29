//
//  FeaturedWorkshopCard.swift
//  LineUpApp
//
//  Created by Canessane Ramya on 28/10/2026.
//

import SwiftUI

struct FeaturedWorkshopCard: View {
        let workshop: Workshop
        let numberOfPages: Int
        let currentIndex: Int
    
        private func formatFeaturedDate(_ date: Date) -> String {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "fr_FR")
            formatter.dateFormat = "EEE d MMM · HH:mm" // Ex: ven. 5 sept. · 20:30
            return formatter.string(from: date).capitalized
        }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Image(workshop.picture)
                .resizable()
                .scaledToFill()
                .frame(height: 180)
                .overlay {
                    LinearGradient(
                        colors: [.clear, .black.opacity(0.8)],
                        startPoint: .center,
                        endPoint: .bottom
                    )
                }
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .overlay(alignment: .topLeading) {
                    FeaturedStarBadge()
                        .padding(16)
                }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(workshop.category.name.uppercased())
                    .font(.system(size: 10, weight: .bold))
                    .foregroundStyle(.white.opacity(0.8))
                
                Text(workshop.name)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                
                Text("\(formatFeaturedDate(workshop.startTime))  -  \(workshop.location)")
                    .font(.system(size: 11))
                    .foregroundStyle(.white.opacity(0.7))
            }
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(spacing: 6) {
                ForEach(0..<numberOfPages, id: \.self) { index in
                    Circle()
                        .fill(index == currentIndex ? Color.white : Color.white.opacity(0.4))
                        .frame(width: 6, height: 6)
                }
            }
            .padding(16)
        }
    }
}

#Preview {
    FeaturedWorkshopCard(
        workshop: Workshop(
            id: UUID(),
            name: "Maitrise de la voix",
            startTime: Date(),
            endTime: Date().addingTimeInterval(3600),
            capacityMax: 10,
            subscribersNb: 5,
            description: "",
            category: Category(id: UUID(), name: "Voix")
        ),
        numberOfPages: 3,
        currentIndex: 0
    )
    .padding()
}


