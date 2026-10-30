//
//  LoginRequest.swift
//  LineUpApp
//
//  Created by Guillaume Richard on 22/10/2026.
//

import Foundation

// POST /auth/login (LoginDTO côté Vapor)
struct LoginRequest: Encodable {
    let email: String
    let password: String
}
