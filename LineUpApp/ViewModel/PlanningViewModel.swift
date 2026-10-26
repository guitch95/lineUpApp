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

    private let workshopService: WorkshopService
    var selectedDay: Date

    init(workshopService: WorkshopService = WorkshopService()) {
        self.workshopService = workshopService
        self.selectedDay = Calendar.current.startOfDay(for: Date())
    }

    var workshops: [Workshop] {
        workshopService.workshops
    }

    var errorMessage: String? {
        workshopService.errorMessage
    }

    var days: [Date] {  // un jour par date distincte des ateliers récupérés
        let calendar = Calendar.current
        return Set(workshops.map { calendar.startOfDay(for: $0.startTime) })
            .sorted()
    }

    var workshopsForSelectedDay: [Workshop] {  // filtre pour afficher les ateliers du jour selectionné
        workshops
            .filter {
                Calendar.current.isDate($0.startTime, inSameDayAs: selectedDay)
            }
            .sorted { $0.startTime < $1.startTime }
    }

    func loadWorkshops() async {
        await workshopService.fetchWorkshops()
        if let first = days.first, !days.contains(selectedDay) {
            selectedDay = first
        }
    }
}
