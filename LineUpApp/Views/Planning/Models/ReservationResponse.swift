//
//  ReservationResponse.swift
//  LineUpApp
//
//  Created by Apprenant151 on 27/10/2026.
//

import Foundation

struct ReservationResponse: Identifiable, Decodable {
    let id: UUID
    let userID: UUID
    let status: ReservationStatus
    let workshopID: UUID
    let nameWorkshop: String
    let startTimeWorkshop: Date
    let endTimeWorkshop: Date
}

extension ReservationResponse {
    private static let locations = [
        "Maitrise de la voix": "Cours des Célestins",
        "Lecture perchée": "Studio Artaud",
        "Éloquence en scène": "Salle Comédie",
        "Corps & Récit": "Cours des Arts",
        "Mise en lumière": "Atelier technique",
    ]
    var location: String { Self.locations[nameWorkshop] ?? "Salle 01" }
}
