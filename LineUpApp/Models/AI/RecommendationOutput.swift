//
//  Recommendation.swift
//  LineUpApp
//
//  Created by Guillaume Richard on 29/10/2026.
//

import Foundation
import FoundationModels

@Generable
struct Recommendation {
    @Guide(description: "Les ateliers recommandés, du plus pertinent au moins pertinent", .count(1...3))
    let suggestions: [WorkshopSuggestion]
}
