//
//  WorkshopDetailView.swift
//  LineUpApp
//
//  Created by Apprenant123 on 27/10/2026.
//

import SwiftUI

struct WorkshopDetailView: View {
    @State var viewModel: WorkshopDetailViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                // --- 1. EN-TÊTE AVEC IMAGE ET BOUTONS SUPERPOSÉS ---
                ZStack(alignment: .topLeading) {
                    // L'image de l'atelier
                    Image(viewModel.workshop.picture)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 280)
                        .clipShape(RoundedRectangle(cornerRadius: 24,
                                                    style: .continuous))
                        .ignoresSafeArea(edges: .top)
                    
                    // Les boutons par-dessus l'image
                    HStack {
                        // Bouton Retour
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "arrow.left")
                                .foregroundColor(.primary)
                                .padding(12)
                                .background(.white)
                                .clipShape(Circle())
                        }
                        
                        Spacer()
                        
                        // Bouton Favori
                        Button {
                            viewModel.isFavorite.toggle()
                        } label: {
                            Image(systemName: viewModel.isFavorite ? "heart.fill" : "heart")
                                .foregroundColor(viewModel.isFavorite ? .red : .primary)
                                .padding(12)
                                .background(.white)
                                .clipShape(Circle())
                        }
                    }
                    .padding()
                }
                
                // --- 2. INFORMATIONS TEXTUELLES ---
                VStack(alignment: .leading, spacing: 6) {
                    Text(viewModel.workshop.category.name.uppercased())
                        .font(.caption2)
                        .fontWeight(.bold)
                        .foregroundColor(Color("redBtnColor"))
                    
                    Text(viewModel.workshop.name)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    Text(viewModel.workshop.speaker)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                // --- 3. BLOC DATE, HEURE ET LIEU ---
                HStack(alignment: .top, spacing: 30) {
                    // Colonne Date
                    VStack(alignment: .leading, spacing: 4) {
                        Text("DATE")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                        Text(viewModel.dateText)
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                    }
                    
                    // Colonne Heure
                    VStack(alignment: .leading, spacing: 4) {
                        Text("HEURE")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                        Text(viewModel.timeText)
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                    }
                    
                    // Colonne Lieu
                    VStack(alignment: .leading, spacing: 4) {
                        Text("LIEU")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                        Text(viewModel.locationText)
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                    }
                }
                .padding(.vertical, 4)
                
                // --- 4. DESCRIPTION ---
                Text(viewModel.workshop.description)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .padding(.vertical, 4)
                
                // --- 5. PROGRESSION ET PLACES ---
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("\(viewModel.subscribersNb)/\(viewModel.workshop.capacityMax) places réservées")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Spacer()
                        
                        Text("\(viewModel.remainingPlaces) disponibles")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(Color("availableGreen"))
                    }
                    
                    ProgressView(value: viewModel.progress)
                        .tint(Color("redBtnColor"))
                        .scaleEffect(x: 1, y: 1.5, anchor: .center)
                }
                .padding(.vertical, 4)
                
                // --- 6. BOUTON D'ACTION (Composant externe) ---
                BookingActionButton(viewModel: viewModel)
                
            } // Fin de la VStack principale
            .padding()
        } // Fin de la ScrollView
        .background(Color("bgColor"))
        .navigationBarHidden(true)
    } // Fin de var body
} // Fin de struct WorkshopDetailView

#Preview {
    WorkshopDetailView(viewModel: WorkshopDetailViewModel(workshop: Workshop.samples[4]))
}
