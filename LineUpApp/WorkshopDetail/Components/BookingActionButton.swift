//
//  BookingActionButton.swift
//  LineUpApp
//
//  Created by Apprenant123 on 27/10/2026.
//
import SwiftUI

struct BookingActionButton: View {
    @Bindable var viewModel: WorkshopDetailViewModel
    
    var body: some View {
        Button {
            if viewModel.bookingState == .available {
                viewModel.reserve()
            } else if viewModel.bookingState == .reserved {
                viewModel.cancelReservation()
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
        .disabled(viewModel.bookingState == .full)
        .padding(.top, 8)
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
