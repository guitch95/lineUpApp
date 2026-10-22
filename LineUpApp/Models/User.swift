//
//  User.swift
//  lineUpAPI
//
//  Created by Guillaume Richard on 09/10/2026.
//

import Foundation

struct User: Identifiable, Codable {

    let id: UUID
    let name: String
    let email: String
    let passwordHash: String
    let role: UserRole
    let createdAt: Date?
    let reservations: [Reservation]

}
