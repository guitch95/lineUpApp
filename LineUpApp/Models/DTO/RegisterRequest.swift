//
//  RegisterRequest.swift
//  LineUpApp
//
//  Created by Guillaume Richard on 22/10/2026.
//

import Foundation

// POST /users (CreateUserDTO côté Vapor)
struct RegisterRequest: Encodable {
    let name: String
    let email: String
    let password: String
}
