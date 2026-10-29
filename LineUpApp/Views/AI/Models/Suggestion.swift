//
//  Suggestion.swift
//  LineUpApp
//
//  Created by Guillaume Richard on 29/10/2026.
//

import Foundation

/// Une suggestion en cours d'écriture ou terminée
struct Suggestion: Identifiable {
    let id: Int              // position dans la réponse, stable pendant le streaming
    let name: String         // tel qu'écrit par le modèle (peut être incomplet pendant le streaming)
    let reason: String
    let workshop: Workshop?  // le vrai atelier, dès que le nom correspond
}

