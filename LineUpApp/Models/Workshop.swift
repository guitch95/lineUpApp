//
//  Workshop.swift
//  LineUpApp
//
//  Created by Apprenant151 on 21/10/2026.
//

import Foundation

struct Workshop: Identifiable {

    let id: UUID
    let name: String
    let startTime: Date
    let endTime: Date
    let capacityMax: Int
    let subscribersNb: Int
    let description: String
    let category: Category

    init(
        id: UUID,
        name: String,
        startTime: Date,
        endTime: Date,
        capacityMax: Int,
        subscribersNb: Int,
        description: String,
        category: Category
    ) {
        self.id = id
        self.name = name
        self.startTime = startTime
        self.endTime = endTime
        self.capacityMax = capacityMax
        self.subscribersNb = subscribersNb
        self.description = description
        self.category = category
    }

}
