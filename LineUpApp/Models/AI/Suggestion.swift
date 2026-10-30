//
//  Suggestion.swift
//  LineUpApp
//
//  Created by Guillaume Richard on 29/10/2026.
//

import Foundation

/// Un atelier recommandé par l'assistant, avec la raison
struct Suggestion: Identifiable {
    let workshop: Workshop
    let reason: String

    var id: UUID { workshop.id }
}

