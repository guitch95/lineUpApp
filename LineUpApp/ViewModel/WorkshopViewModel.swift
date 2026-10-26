//
//  WorkshopViewModel.swift
//  LineUpApp
//
//  Created by Apprenant123 on 22/10/2026.
//

import Foundation
import Combine

enum BookingState { //définit les 3 états possibles pour un atelier par rapport à l'utilisateur
    case available   // on peut réserver
    case reserved    // l'utilisateur a déjà sa place
    case full        // complet, et l'utilisateur n'est pas inscrit
}

@MainActor
final class WorkshopDetailViewModel: ObservableObject {

    let workshop: Workshop

    @Published private(set) var subscribersNb: Int
    @Published private(set) var isReserved: Bool
    @Published var isFavorite: Bool = false //Un booléen simple pour dire si l'atelier est en favori ou non (initialisé à false).

    init(workshop: Workshop, isReserved: Bool = false) {
        self.workshop = workshop
        self.subscribersNb = workshop.subscribersNb
        self.isReserved = isReserved
    }

    var remainingPlaces: Int { //Calcule le nombre de places restantes
        max(workshop.capacityMax - subscribersNb, 0)
    }

    var progress: Double { //Calcul pour la barre de progression
        guard workshop.capacityMax > 0 else { return 0 }
        return Double(subscribersNb) / Double(workshop.capacityMax)
    }

    var bookingState: BookingState { //Détermine automatiquement si l'atelier est réservé, complet, ou disponible selon les règles métier.
        if isReserved { return .reserved }
        if remainingPlaces == 0 { return .full }
        return .available
    }

    var categoryText: String { workshop.category.name.uppercased() }
    var speakerText: String { workshop.speaker ?? "Intervenant à venir" }
    var locationText: String { workshop.location ?? "Lieu à définir" }
    var reservedText: String { "\(subscribersNb)/\(workshop.capacityMax) places réservées" }
    var availableText: String { "\(remainingPlaces) disponibles" }

    var dateText: String { // On formate la date avec cette propriété calculée
        workshop.startTime.formatted(
            .dateTime.weekday(.abbreviated).day().month(.abbreviated)
                .locale(Locale(identifier: "fr_FR"))
        )
    }

    var timeText: String { // On formate l'heure avec cette propriété calculée
        "\(Self.hourFormatter.string(from: workshop.startTime)) – \(Self.hourFormatter.string(from: workshop.endTime))"
    }

    // On crée le formatter une seule fois
    private static let hourFormatter: DateFormatter = { // outil standard d'iOS pour traduire les dates en textes
        let f = DateFormatter()
        f.dateFormat = "HH'h'mm"   // donne "15h00"
        return f
    }()

    func reserve() { // fonction qui vérifie qu'on peut réserver
        guard bookingState == .available else { return }
        subscribersNb += 1
        isReserved = true
        // TODO: appeler l'API (POST /reservations) quand le back sera prêt
    }

    func cancelReservation() { // fonction qui vérifie l'annulation de la réservation
        guard isReserved else { return }
        subscribersNb -= 1
        isReserved = false
        // TODO: appeler l'API (DELETE/PATCH réservation)
    }
}
