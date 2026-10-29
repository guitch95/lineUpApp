//
//  WorkshopCategory.swift
//  LineUpApp
//
//  Created by Canessane Ramya on 27/10/2026.
//

import Foundation

enum WorkshopCategory: String, Codable, CaseIterable {
    case voix = "Voix"
    case impro = "Impro"
    case theatre = "Théâtre"
    case danse = "Danse"
    case comedie = "Comédie"
    case technique = "Technique"
    case miseEnScene = "Mise en scène"
    case all = "Tous"
}

