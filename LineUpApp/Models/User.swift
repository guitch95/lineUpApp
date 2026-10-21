//
//  User.swift
//  lineUpAPI
//
//  Created by Guillaume Richard on 09/10/2026.
//

import Foundation

struct User: Identifiable {

    let id: UUID
    let name: String
    let email: String
    let passwordHash: String
    let role: UserRole
    let createdAt: Date?
    let reservations: [Reservation]

    init(
        id: UUID,
        name: String,
        email: String,
        passwordHash: String,
        role: UserRole = .festivalier,
        createdAt: Date?,
        reservations: [Reservation]
    ) {
        self.id = id
        self.name = name
        self.email = email
        self.passwordHash = passwordHash
        self.role = role
        self.createdAt = createdAt
        self.reservations = reservations
    }
}
