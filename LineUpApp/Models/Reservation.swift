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

}
