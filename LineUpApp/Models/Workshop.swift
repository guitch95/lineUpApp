//
//  Workshop.swift
//  LineUpApp
//
//  Created by Apprenant151 on 21/10/2026.
//

import Foundation
import SwiftUI

struct Workshop: Identifiable, Decodable {
    
    let id: UUID
    let name: String
    let startTime: Date
    let endTime: Date
    let capacityMax: Int
    let subscribersNb: Int
    let description: String
    let category: Category
    
    var isComplete: Bool {
        subscribersNb == capacityMax
    }
    var remainingPlaces: Int {
        capacityMax - subscribersNb
    }
    
    var badgeText: String {
        if isComplete {
            return "Complet"
        } else if remainingPlaces == 1 {
            return "1 place"
        } else {
            return "\(remainingPlaces) places"
        }
    }
    
    var badgeColor: Color {
        isComplete ? .btnListeAttente : .availableGreen
    }
}

extension Workshop {
    // Intervenants possibles selon la catégorie (les intervenants ne sont pas en BDD)
    var speaker: String {
        let speakers: [String]
        switch category.name {
        case "Théâtre":
            speakers = ["Claire Morel", "Antoine Leroy", "Hélène Garnier"]
        case "Danse":
            speakers = ["Nathalie Voss", "Inès Duarte", "Julien Marchal"]
        case "Comédie":
            speakers = ["Karim Belkacem", "Léa Fontaine", "Thomas Rivière"]
        case "Voix":
            speakers = ["Collectif La Voix Haute", "Sarah Benali", "Marc Delorme"]
        case "Impro":
            speakers = ["Compagnie Les Improbables", "Camille Roux", "Hugo Lambert"]
        case "Technique":
            speakers = ["Lucie Granger", "Paul Mercier", "Yann Lebrun"]
        case "Mise en scène":
            speakers = ["Élise Moreau", "Vincent Arnaud"]
        default:
            speakers = ["Intervenant invité"]
        }
        // Le nombre de lettres du nom choisit l'intervenant : toujours le même pour un atelier
        return speakers[name.count % speakers.count]
    }
    
    // Une salle par catégorie (les lieux ne sont pas en BDD)
    var location: String {
        switch category.name {
        case "Théâtre":
            return "Grande salle"
        case "Danse":
            return "Studio de danse"
        case "Comédie":
            return "Salle Comédie"
        case "Voix":
            return "Studio Artaud"
        case "Impro":
            return "Café-théâtre"
        case "Technique":
            return "Atelier technique"
        case "Mise en scène":
            return "Salle de répétition"
        default:
            return "Salle 01"
        }
    }
    // Image choisie selon la catégorie (les images ne sont pas en BDD)
    var picture: String {
        switch category.name {
        case "Théâtre":
            return "LecturePerchee"
        case "Danse":
            return "CorpsRecit"
        case "Comédie":
            return "EloquenceEnScene"
        case "Voix":
            return "MaitriseDeLaVoix"
        case "Impro":
            return "MiseEnLumiere"
        case "Technique":
            return "Technique"
        default:
            return "Placeholder"
        }
    }
}
