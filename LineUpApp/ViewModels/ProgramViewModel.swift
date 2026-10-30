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
    var workshops: [Workshop] {
        workshopService.workshops
    }
    
    // Premier chargement : on n'a encore aucun atelier à afficher
    var isFirstLoading: Bool {
        workshopService.isLoading && workshops.isEmpty
    }
    
    var errorMessage: String? {
        workshopService.errorMessage
    }
    
    var featuredWorkshops: [Workshop] {
        Array(workshops.prefix(3))
    }
    
    // Jours distincts (sans l'heure) des ateliers récupérés en BDD, triés
    var availableDays: [Date] {
        let calendar = Calendar.current
        return Set(workshops.map { calendar.startOfDay(for: $0.startTime) }).sorted()
    }
    
    // Catégories distinctes des ateliers récupérés en BDD, triées par ordre alphabétique
    var categories: [String] {
        Set(workshops.map(\.category.name)).sorted { $0.localizedStandardCompare($1) == .orderedAscending }
    }

    var selectedDate: Date = Date()
    
    var selectedCategory: String? = nil
    
    func fetchWorkshops() async {
        await workshopService.fetchWorkshops()
        // Sélectionne le premier jour dispo si la date courante ne correspond à aucun atelier
        if !availableDays.contains(where: { Calendar.current.isDate($0, inSameDayAs: selectedDate) }),
           let firstDay = availableDays.first {
            selectedDate = firstDay
        }
    }
    
    var filteredWorkshops: [Workshop] {
        let calendar = Calendar.current
        
        return workshops.filter { workshop in
            // Vérifie si la date de l'atelier tombe le même jour que la date sélectionnée (en ignorant les heures, minutes et secondes)
            let matchesDate = calendar.isDate(workshop.startTime, inSameDayAs: selectedDate)
            
            let matchesCategory: Bool
            
            if let selectedCategory,
               selectedCategory != "Tous" {
                matchesCategory = workshop.category.name == selectedCategory
            } else {
                matchesCategory = true
            }
            return matchesDate && matchesCategory
        }
    }
}



