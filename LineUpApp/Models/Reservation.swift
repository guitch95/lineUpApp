//
//  Reservation.swift
//  LineUpApp
//
//  Created by Guillaume Richard on 16/10/2026.
//

import Foundation

struct Reservation: Identifiable {

    let id: UUID
    let status: ReservationStatus
    let user: User
    let workshop: Workshop

    init(
        id: UUID = UUID(),
        status: ReservationStatus,
        user: User,
        workshop: Workshop
    ) {
        self.id = id
        self.status = status
        self.user = user
        self.workshop = workshop
    }
}
