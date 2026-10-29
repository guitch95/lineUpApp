//
//  WorkshopViewModel.swift
//  LineUpApp
//
//  Created by Apprenant123 on 22/10/2026.
//

import Foundation

enum BookingState {
    case available
    case reserved
    case full
}

@Observable
final class WorkshopDetailViewModel {
    let workshop: Workshop
    private let reservationService: ReservationService

    var subscribersNb: Int
    var isLoading = false

    // Id de la réservation de l'utilisateur pour cet atelier (nil si pas réservé)
    private var reservationID: UUID?

    var isReserved: Bool {
        reservationID != nil
    }

    var errorMessage: String? {
        reservationService.errorMessage
    }

    init(workshop: Workshop, reservationService: ReservationService = ReservationService()) {
        self.workshop = workshop
        self.reservationService = reservationService
        self.subscribersNb = workshop.subscribersNb
    }
    
    var remainingPlaces: Int {
        max(workshop.capacityMax - subscribersNb, 0) // Correction du -
    }
    
    var progress: Double {
        guard workshop.capacityMax > 0 else { return 0 }
        return Double(subscribersNb) / Double(workshop.capacityMax)
    }
    
    var bookingState: BookingState {
        if isReserved { return .reserved }
        if remainingPlaces == 0 { return .full }
        return .available
    }
    
    // --- PROPRIÉTÉS CALCULÉES POUR L'AFFICHAGE ---
    
    var dateText: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.dateFormat = "EEE d MMM"
        return formatter.string(from: workshop.startTime).capitalized
    }
    
    var timeText: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH'h'mm"
        let start = formatter.string(from: workshop.startTime)
        let end = formatter.string(from: workshop.endTime)
        return "\(start) - \(end)"
    }
    
    var locationText: String {
        return "Atelier principal" // Ou une propriété de ton model Workshop si elle existe
    }
    
    // --- FONCTIONS ---
    
    // Récupère les réservations de l'utilisateur pour savoir s'il a déjà réservé cet atelier
    func loadReservation(token: String?) async {
        guard let token else { return }
        await reservationService.fetchReservationsUser(token: token)
        reservationID = reservationService.reservations
            .first { $0.workshopID == workshop.id && $0.status != .annulee }?
            .id
    }

    func reserve(token: String?) async {
        guard bookingState == .available, let token else { return }
        isLoading = true
        defer { isLoading = false }
        if let reservation = await reservationService.createReservation(workshopID: workshop.id, token: token) {
            reservationID = reservation.id
            subscribersNb += 1
        }
    }

    func cancelReservation(token: String?) async {
        guard let reservationID, let token else { return }
        isLoading = true
        defer { isLoading = false }
        if await reservationService.deleteReservation(id: reservationID, token: token) {
            self.reservationID = nil
            subscribersNb = max(subscribersNb - 1, 0)
        }
    }
}
