//
//  Reservation.swift
//  LineUpApp
//
//  Created by Guillaume Richard on 16/10/2026.
//

import Foundation

struct Reservation: Identifiable, Hashable {
    let id: UUID
    let titreAtelier: String
    let lieu: String
    let dateDebut: Date
    let dateFin: Date

    init(id: UUID = UUID(), titreAtelier: String, lieu: String, dateDebut: Date, dateFin: Date) {
        self.id = id
        self.titreAtelier = titreAtelier
        self.lieu = lieu
        self.dateDebut = dateDebut
        self.dateFin = dateFin
    }
}
