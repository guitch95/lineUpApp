//
//  WorkshopViewModel.swift
//  LineUpApp
//
//  Created by Apprenant123 on 22/10/2026.
//

import Foundation

enum BookingState {
    case available
    case reserved
    case full
}

@Observable
final class WorkshopDetailViewModel {
    let workshop: Workshop
    
    var subscribersNb: Int
    var isReserved: Bool
    var isFavorite: Bool = false
    
    init(workshop: Workshop, isReserved: Bool = false) {
        self.workshop = workshop
        self.subscribersNb = workshop.subscribersNb
        self.isReserved = isReserved
    }
    
    var remainingPlaces: Int {
        max(workshop.capacityMax - subscribersNb, 0) // Correction du -
    }
    
    var progress: Double {
        guard workshop.capacityMax > 0 else { return 0 }
        return Double(subscribersNb) / Double(workshop.capacityMax)
    }
    
    var bookingState: BookingState {
        if isReserved { return .reserved }
        if remainingPlaces == 0 { return .full }
        return .available
    }
    
    // --- PROPRIÉTÉS CALCULÉES POUR L'AFFICHAGE ---
    
    var dateText: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.dateFormat = "EEE d MMM"
        return formatter.string(from: workshop.startTime).capitalized
    }
    
    var timeText: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH'h'mm"
        let start = formatter.string(from: workshop.startTime)
        let end = formatter.string(from: workshop.endTime)
        return "\(start) - \(end)"
    }
    
    var locationText: String {
        return "Atelier principal" // Ou une propriété de ton model Workshop si elle existe
    }
    
    // --- FONCTIONS ---
    
    func reserve() {
        guard bookingState == .available else { return }
        subscribersNb += 1
        isReserved = true
    }
    
    func cancelReservation() {
        guard isReserved else { return }
        subscribersNb -= 1
        isReserved = false
    }
}
