//
//  BookingActionButton.swift
//  LineUpApp
//
//  Created by Apprenant123 on 27/10/2026.
//
import SwiftUI

struct BookingActionButton: View {
    @Bindable var viewModel: WorkshopDetailViewModel
    @Environment(AuthService.self) private var authService
    @State private var showCancelConfirmation = false

    var body: some View {
        Button {
            Task {
                await viewModel.reserve(token: authService.token)
            }
        } label: {
            Text(buttonTitle)
                .font(Font.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(buttonBackgroundColor)
                .cornerRadius(12)
        }
        .disabled(viewModel.bookingState != .available || viewModel.isLoading)
        .padding(.top, 8)

        // Bouton d'annulation séparé, visible uniquement si l'atelier est réservé
        if viewModel.bookingState == .reserved {
            Button(role: .destructive) {
                showCancelConfirmation = true
            } label: {
                Text("Annuler ma réservation")
                    .font(Font.headline)
                    .foregroundColor(Color("redBtnColor"))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color("redBtnColor"), lineWidth: 1.5)
                    )
            }
            .disabled(viewModel.isLoading)
            .confirmationDialog(
                "Annuler votre réservation pour cet atelier ?",
                isPresented: $showCancelConfirmation,
                titleVisibility: .visible
            ) {
                Button("Annuler ma réservation", role: .destructive) {
                    Task {
                        await viewModel.cancelReservation(token: authService.token)
                    }
                }
            }
        }

        if let errorMessage = viewModel.errorMessage {
            Text(errorMessage)
                .font(.caption)
                .foregroundStyle(.red)
        }
    }
    
    // Les propriétés calculées logées proprement dans le composant
    private var buttonTitle: String {
        switch viewModel.bookingState {
        case .available: return "Réserver cet atelier"
        case .reserved: return "Votre place est confirmée"
        case .full: return "Atelier complet"
        }
    }
    
    private var buttonBackgroundColor: Color {
        switch viewModel.bookingState {
        case .available: return Color("redBtnColor")
        case .reserved: return Color("availableGreen")
        case .full: return Color.gray
        }
    }
}
