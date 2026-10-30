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
    @Environment(AuthService.self) private var authService
    @Environment(FavoriteService.self) private var favoriteService
    var body: some View {
        ZStack {
            VStack {
                Image(viewModel.workshop.picture)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)

                VStack(alignment: .leading) {
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
                            Text(viewModel.workshop.location)
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
                            Text(
                                "\(viewModel.subscribersNb)/\(viewModel.workshop.capacityMax) places réservées"
                            )
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

                }
                .padding()
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        favoriteService.toggle(viewModel.workshop)
                    } label: {
                        Image(
                            systemName: favoriteService.isFavorite(
                                viewModel.workshop
                            ) ? "heart.fill" : "heart"
                        )
                        .foregroundStyle(
                            favoriteService.isFavorite(viewModel.workshop)
                                ? .redBtn : .primary
                        )
                    }
                }
            }
        }
        .background(.bg)
        .ignoresSafeArea()

    }
}

#Preview {
    NavigationStack {
        WorkshopDetailView(
            viewModel: WorkshopDetailViewModel(workshop: Workshop.samples[0])
        )
    }
    .environment(AuthService())
    .environment(FavoriteService())
}
