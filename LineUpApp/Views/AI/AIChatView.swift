//
//  AIChatView.swift
//  LineUpApp
//
//  Created by Guillaume Richard on 29/10/2026.
//

import FoundationModels
import SwiftUI

struct AIChatView: View {
    State private var service = RecommendationService()
    @State private var request = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Trouve ton atelier")
                .font(.title)
                .bold()

            TextField("Ex : je suis timide et je veux travailler ma voix", text: $request, axis: .vertical)
                .lineLimit(5...10)
                .padding()
                .background(.gray.opacity(0.1), in: .rect(cornerRadius: 12))

            Button {
                Task {
                    await service.recommend(for: request, among: MockData.workshops)
                }
            } label: {
                Group {
                    if service.isLoading {
                        ProgressView()
                            .tint(.white)
                    } else {
                        Text("Me proposer des ateliers")
                            .bold()
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(.indigo, in: .rect(cornerRadius: 12))
                .foregroundStyle(.white)
            }
            .disabled(service.isLoading || request.trimmingCharacters(in: .whitespaces).isEmpty)

            if let errorMessage = service.errorMessage {
                Text(errorMessage)
                    .foregroundStyle(.red)
            }

            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(service.suggestions) { suggestion in
                        VStack(alignment: .leading, spacing: 6) {
                            Text(suggestion.workshop?.name ?? suggestion.name)
                                .font(.headline)
                            // Détails affichés dès que le nom correspond à un vrai atelier
                            if let workshop = suggestion.workshop {
                                Text("\(workshop.category.categoryName) · \(workshop.startTime.formatted(.dateTime.weekday(.wide).hour().minute()))")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                    .transition(.opacity)
                            }
                            Text(suggestion.reason)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(.indigo.opacity(0.08), in: .rect(cornerRadius: 12))
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                    }
                }
                .animation(.easeOut(duration: 0.25), value: service.suggestions.map(\.id))
                .animation(.easeOut(duration: 0.25), value: service.suggestions.map { $0.workshop?.id })
            }

            Spacer(minLength: 0)
        }
    }


#Preview {
    AIChatView()
}
