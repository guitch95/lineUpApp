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

    var body: some View {
        Button {
            Task {
                if viewModel.bookingState == .available {
                    await viewModel.reserve(token: authService.token)
                } else if viewModel.bookingState == .reserved {
                    await viewModel.cancelReservation(token: authService.token)
                }
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
        .disabled(viewModel.bookingState == .full || viewModel.isLoading)
        .padding(.top, 8)

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
