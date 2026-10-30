//
//  ProfileView.swift
//  LineUpApp
//
//  Created by Guillaume Richard on 16/10/2026.
//

import SwiftUI

struct ProfileView: View {
    @Environment(AuthService.self) private var authService
    @State private var isLoggingOut = false
    @State private var viewModelProfile = ProfileViewModel()

    // Initiales de l'utilisateur connecté : "Guillaume Richard" -> "GR"
    private var initials: String {
        let words = (authService.user?.name ?? "").split(separator: " ")
        // Gardes les 2 premiers mots .prefix(2)
        return words.prefix(2).compactMap(\.first).map(String.init).joined().uppercased()
    }

    var body: some View {
        ZStack {
            Color.bg
            VStack(spacing: 20) {
                HStack {
                    Text("Profil")
                        .font(.system(size: 26))
                        .fontWeight(.bold)
                        .fontDesign(.serif)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                Circle()
                    .fill(.black)
                    .frame(width: 80, height: 80)
                    .overlay {
                        Text(initials)
                            .font(.title)
                            .bold()
                            .foregroundStyle(.white)
                    }

                VStack(spacing: 4) {
                    Text(authService.user?.name ?? "")
                        .font(.title2)
                        .bold()
                    Text(authService.user?.email ?? "")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                StatCard(
                    title: viewModelProfile.reservedCount > 1 ? "Ateliers réservés" : "Atelier Réservé",
                    value: viewModelProfile.reservedCount
                )

                Button {
                    isLoggingOut = true
                    Task {
                        try? await Task.sleep(for: .seconds(1))
                        authService.logout()
                    }
                } label: {
                    Group {
                        if isLoggingOut {
                            ProgressView()
                        } else {
                            Text("Se déconnecter")
                                .bold()
                                .foregroundStyle(.redBtn)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(.white, in: .rect(cornerRadius: 12))
                }
                .disabled(isLoggingOut)

                Spacer()
            }
            .padding(.top, 40)
            .padding(18)
            .task {
                await viewModelProfile.loadReservations(token: authService.token)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ProfileView()
        .environment(AuthService())
}
