//
//  EventRow.swift
//  LineUpApp
//
//  Created by Canessane Ramya on 17/10/2026.
//

import SwiftUI

struct EventRow: View {
    let workshop: Workshop
    
    private func formatTime(_ date: Date) -> String {
        date.formatted(.dateTime.hour().minute().locale(Locale(identifier: "fr_FR")))
    }
    
    var body: some View {
            NavigationLink {
                WorkshopDetailView(viewModel: WorkshopDetailViewModel(workshop: workshop))
            } label: {
                HStack {
                    Image(workshop.picture)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 68, height: 68)
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text(workshop.name)
                                .font(.system(size: 14))
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                            CategoryTag(category: workshop.category.name)
                        }
                        
                        Text(workshop.speaker)
                            .font(.system(size: 12))
                            .fontWeight(.regular)
                            .foregroundStyle(.fontGrayBtn)
                        
                        HStack(spacing: 0) {
                            Text("\(formatTime(workshop.startTime)) – \(formatTime(workshop.endTime))")
                            Text(" • \(workshop.location)")
                            Spacer()
                            AvailabilityBadge(workshop: workshop)
                        }
                        .font(.system(size: 11))
                        .fontWeight(.regular)
                        .foregroundStyle(.btnListeAttente)
                    }
                }
            }
            .buttonStyle(.plain) // Empêche le style de bouton gris/bleu moche sur toute la ligne
        }
}

#Preview {
    EventRow(workshop: Workshop.samples[0])
        .padding()
}
