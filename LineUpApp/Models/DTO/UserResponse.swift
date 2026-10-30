//
//  UserResponse.swift
//  LineUpApp
//
//  Created by Guillaume Richard on 22/10/2026.
//

import Foundation

// Réponse de GET /auth/me et POST /users (correspond à UserDTO)
struct UserResponse: Decodable {
    let id: UUID
    let name: String
    let email: String
}
