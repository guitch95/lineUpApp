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
    private let workshopService = WorkshopService()
    let availableDays: [Date] = Workshop.sampleDays
    
    var workshops: [Workshop] {
        workshopService.workshops
    }
    
    var errorMessage: String? {
        workshopService.errorMessage
    }
    
    var selectedDate: Date = Workshop.sampleDays.first ?? Date()
    
    func fetchWorkshops() async {
        await workshopService.fetchWorkshops()
    }
    
    var filteredWorkshops: [Workshop] {
        let calendar = Calendar.current
        
        return workshops.filter { workshop in
            // Vérifie si la date de l'atelier tombe le même jour que la date sélectionnée (en ignorant les heures, minutes et secondes)
            calendar.isDate(workshop.startTime, inSameDayAs: selectedDate)
        }
    }
}
