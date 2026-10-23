//
//  ProgrammeViewModel.swift
//  LineUpApp
//
//  Created by Guillaume Richard on 16/10/2026.
//

import Foundation
import SwiftUI

@Observable
final class ProgramViewModel {
    let workshops: [Workshop] = Workshop.samples
    let availableDays: [Date] = Workshop.sampleDays
    
    var selectedDate: Date = Workshop.sampleDays.first ?? Date()
    
    var filteredWorkshops: [Workshop] {
        let calendar = Calendar.current
        
        return workshops.filter { workshop in
            // Vérifie si la date de l'atelier tombe le même jour que la date sélectionnée (en ignorant les heures, minutes et secondes)
            calendar.isDate(workshop.startTime, inSameDayAs: selectedDate)
        }
    }
}
