//
//  FavorisView.swift
//  LineUpApp
//
//  Created by Guillaume Richard on 16/10/2026.
//

import SwiftUI

struct FavoriteView: View {
    @Environment(FavoriteService.self) private var favoriteService
    @State private var workshopService = WorkshopService()

    // Ateliers mis en favori, triés par date
    private var favoriteWorkshops: [Workshop] {
        workshopService.workshops
            .filter { favoriteService.isFavorite($0) }
            .sorted { $0.startTime < $1.startTime }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 28) {
                    Text("Mes favoris")
                        .font(.system(size: 26))
                        .fontWeight(.bold)
                        .fontDesign(.serif)

                    if let errorMessage = workshopService.errorMessage {
                        Text(errorMessage)
                            .font(.caption)
                            .foregroundStyle(.red)
                    }

                    if favoriteWorkshops.isEmpty {
                        Text("Aucun atelier en favori. Appuyez sur le cœur d'un atelier pour l'ajouter ici.")
                            .foregroundStyle(.loginText)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                            .frame(minHeight: 400)
                    } else {
                        ForEach(favoriteWorkshops) { workshop in
                            EventRow(workshop: workshop)
                            Divider()
                        }
                    }
                }
                .padding()
                .task {
                    await workshopService.fetchWorkshops()
                }
            }
            .background(.bg)
        }
    }
}

#Preview {
    FavoriteView()
        .environment(FavoriteService())
        .environment(AuthService())
}
