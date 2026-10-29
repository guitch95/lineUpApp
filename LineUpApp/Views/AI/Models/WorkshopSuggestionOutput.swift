//
//  WorkshopSuggestionOutput.swift
//  LineUpApp
//
//  Created by Guillaume Richard on 29/10/2026.
//

import Foundation
import FoundationModels

@Generable
struct WorkshopSuggestion {
    @Guide(description: "Le nom exact d'un atelier de la liste, recopié à l'identique")
    let workshopName: String

    @Guide(description: "Une phrase qui explique pourquoi cet atelier correspond à la demande")
    let reason: String
}
