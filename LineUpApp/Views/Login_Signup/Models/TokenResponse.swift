//
//  TokenResponse.swift
//  LineUpApp
//
//  Created by Guillaume Richard on 22/10/2026.
//

import Foundation

// Réponse de POST /auth/login (correspond à TokenResponseDTO)
struct TokenResponse: Decodable {
    let token: String
}
