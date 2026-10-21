//
//  Category.swift
//  LineUpApp
//
//  Created by Apprenant151 on 21/10/2026.
//

import Foundation

struct Category: Identifiable {
    let id: UUID
    let name: String
    let workshops: [Workshop]

    init(
        id: UUID,
        name: String,
        workshops: [Workshop]
    ) {
        self.id = id
        self.name = name
        self.workshops = workshops
    }
}
