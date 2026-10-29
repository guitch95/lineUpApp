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
    var speaker: String {
        switch name {
        case "Maitrise de la voix":
            return "Collectif La Voix Haute"
        case "Corps & Récit":
            return "Nathalie Voss"
        case "Mise en lumière":
            return "Lucie Granger"
        default:
            return "Intervenant invité"
        }
    }
    
    var location: String {
        switch name {
        case "Maitrise de la voix":
            return "Cours des Célestins"
        case "Lecture perchée":
            return "Studio Artaud"
        case "Éloquence en scène":
            return "Salle Comédie"
        case "Corps & Récit":
            return "Cours des Arts"
        case "Mise en lumière":
            return "Atelier technique"
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
            return "WorkshopPicture"
        default:
            return "Placeholder"
        }
    }
}
