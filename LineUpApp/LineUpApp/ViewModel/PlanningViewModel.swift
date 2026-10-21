//
//  PlanningViewModel.swift
//  LineUpApp
//
//  Created by Guillaume Richard on 16/10/2026.
//

import Foundation
import Observation

@Observable
final class PlanningViewModel {
    private(set) var reservations: [Reservation]
    var jourSelectionne: Date

    private let calendrier: Calendar = {
        var calendrier = Calendar(identifier: .gregorian)
        calendrier.locale = Locale(identifier: "fr_FR")
        return calendrier
    }()

    init(reservations: [Reservation] = PlanningViewModel.exemples) {
        self.reservations = reservations
        self.jourSelectionne = reservations.first.map { calendrier.startOfDay(for: $0.dateDebut) } ?? Date()
    }

    /// Jours du festival pour lesquels une réservation existe, triés chronologiquement.
    var joursDuFestival: [Date] {
        let jours = Set(reservations.map { calendrier.startOfDay(for: $0.dateDebut) })
        return jours.sorted()
    }

    var nombreReservations: Int {
        reservations.count
    }

    /// Plage d'heures affichée dans la grille, avec un minimum de 8h à 18h.
    var plageHoraire: ClosedRange<Int> {
        let heures = reservations.flatMap {
            [calendrier.component(.hour, from: $0.dateDebut), calendrier.component(.hour, from: $0.dateFin)]
        }
        let min = Swift.min(8, heures.min() ?? 8)
        let max = Swift.max(18, heures.max() ?? 18)
        return min...max
    }

    func reservations(pour jour: Date) -> [Reservation] {
        reservations
            .filter { calendrier.isDate($0.dateDebut, inSameDayAs: jour) }
            .sorted { $0.dateDebut < $1.dateDebut }
    }

    func aUneReservation(le jour: Date) -> Bool {
        !reservations(pour: jour).isEmpty
    }

    /// Position verticale (en heure décimale depuis minuit) du début d'une réservation.
    func heureDecimale(_ date: Date) -> Double {
        let composants = calendrier.dateComponents([.hour, .minute], from: date)
        return Double(composants.hour ?? 0) + Double(composants.minute ?? 0) / 60
    }

    func dureeEnHeures(_ reservation: Reservation) -> Double {
        heureDecimale(reservation.dateFin) - heureDecimale(reservation.dateDebut)
    }

    static let exemples: [Reservation] = {
        var calendrier = Calendar(identifier: .gregorian)
        calendrier.locale = Locale(identifier: "fr_FR")

        func date(jour: Int, heure: Int, minute: Int = 0) -> Date {
            calendrier.date(from: DateComponents(year: 2026, month: 11, day: jour, hour: heure, minute: minute)) ?? Date()
        }

        return [
            Reservation(
                titreAtelier: "Jeu masqué",
                lieu: "Atelier Expression",
                dateDebut: date(jour: 5, heure: 10),
                dateFin: date(jour: 5, heure: 12)
            ),
            Reservation(
                titreAtelier: "Mise en lumière",
                lieu: "Atelier Technique",
                dateDebut: date(jour: 6, heure: 15),
                dateFin: date(jour: 6, heure: 17)
            ),
            Reservation(
                titreAtelier: "Improvisation",
                lieu: "Atelier Jeu",
                dateDebut: date(jour: 7, heure: 11),
                dateFin: date(jour: 7, heure: 12, minute: 30)
            )
        ]
    }()
}
