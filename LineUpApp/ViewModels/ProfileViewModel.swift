//
//  ProfileViewModel.swift
//  LineUpApp
//
//  Created by Guillaume Richard on 30/10/2026.
//

import Foundation
import Observation

@Observable
final class ProfileViewModel {

    private let reservationService: ReservationService  // Gets the reservations from the API

    init(reservationService: ReservationService = ReservationService()) {
        self.reservationService = reservationService
    }

    var reservedCount: Int {  // Reservations of the user without the cancelled ones
        reservationService.reservations.filter { $0.status != .annulee }.count
    }

    func loadReservations(token: String?) async {  // Load the reservations (if token is present)
        guard let token else { return }
        await reservationService.fetchReservationsUser(token: token)
    }
}
