//
//  AIChatView.swift
//  LineUpApp
//
//  Created by Guillaume Richard on 29/10/2026.
//

import FoundationModels
import SwiftUI

struct AIChatView: View {

    @State private var service = RecommendationService()
    @State private var workshopService = WorkshopService()
    @State private var request = ""

    var body: some View {
        NavigationStack {
            VStack {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Trouvez votre atelier")
                        .font(.system(size: 26))
                        .fontWeight(.bold)
                        .fontDesign(.serif)
                    ScrollView {
                        VStack(alignment: .leading, spacing: 12) {
                            ForEach(service.suggestions) { suggestion in
                                NavigationLink {
                                    WorkshopDetailView(viewModel: WorkshopDetailViewModel(workshop: suggestion.workshop))
                                } label: {
                                    VStack(alignment: .leading, spacing: 6) {
                                        Text("\(suggestion.workshop.name)")
                                            .font(.headline)
                                        Text(
                                            "\(suggestion.workshop.category.name) · \(suggestion.workshop.startTime.formatted(.dateTime.weekday(.wide).hour().minute().locale(Locale(identifier: "fr_FR"))))"
                                        )
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                        Text(suggestion.reason)
                                    }
                                    .foregroundStyle(.white)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding()
                                    .background(
                                        .redBtn,
                                        in: .rect(cornerRadius: 12)
                                    )
                                }
                                .buttonStyle(.plain)  // Garde le style de la carte au lieu du style bouton
                            }
                        }
                    }

                    HStack {
                        TextField(
                            "Ici on fait de la magie...",
                            text: $request,
                            axis: .vertical
                        )
                        .frame(maxWidth: .infinity)
                        .lineLimit(1...10)
                        .padding()
                        .background(
                            .gray.opacity(0.1),
                            in: .capsule
                        )

                        Button {
                            Task {
                                await service.recommend(for: request, among: workshopService.workshops)
                            }
                        } label: {
                            Group {
                                if service.isLoading {
                                    ProgressView()
                                        .tint(.white)
                                } else {
                                    Image(systemName: "wand.and.sparkles")
                                        .bold()
                                }
                            }
                            .frame(width: 50, height: 50)
                            .background(.redBtn.opacity(0.9), in: .capsule)
                            .foregroundStyle(.white)
                        }
                        .disabled(
                            service.isLoading
                                || request.trimmingCharacters(in: .whitespaces)
                                    .isEmpty
                        )

                    }
                    if let errorMessage = service.errorMessage {
                        Text(errorMessage)
                            .foregroundStyle(.red)
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(.bg)
            .task {
                await workshopService.fetchWorkshops()
            }
        }
    }
}

#Preview {
    AIChatView()
        .environment(AuthService())
        .environment(FavoriteService())
}
