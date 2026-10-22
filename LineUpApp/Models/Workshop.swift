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
    let location: String
    let speaker: String

}
