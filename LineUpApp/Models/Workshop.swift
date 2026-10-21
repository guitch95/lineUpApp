//
//  Workshop.swift
//  LineUpApp
//
//  Created by Apprenant151 on 21/10/2026.
//

import Foundation

struct Workshop: Identifiable {

    let id: UUID
    let namelet: String
    let startTimelet: Date
    let endTimelet: Date
    let capacityMaxlet: Int
    let subscribersNblet: Int
    let descriptionlet: String
    let category: Category

    init(
        id: UUID,
        namelet: String,
        startTimelet: Date,
        endTimelet: Date,
        capacityMaxlet: Int,
        subscribersNblet: Int,
        descriptionlet: String,
        category: Category
    ) {
        self.id = id
        self.namelet = namelet
        self.startTimelet = startTimelet
        self.endTimelet = endTimelet
        self.capacityMaxlet = capacityMaxlet
        self.subscribersNblet = subscribersNblet
        self.descriptionlet = descriptionlet
        self.category = category
    }

}
