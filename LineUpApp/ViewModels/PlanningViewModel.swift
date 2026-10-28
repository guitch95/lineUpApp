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

    let workshops: [Workshop]
    var selectedDay: Date

    init(workshops: [Workshop]) {
        self.workshops = workshops
        self.selectedDay = Calendar.current.startOfDay(
            for: workshops.first?.startTime ?? Date()
        )
    }

    var workshopsForSelectedDay: [Workshop] {  // filtre pour afficher les ateliers réservés au jour selectionné
        workshops
            .filter {
                Calendar.current.isDate($0.startTime, inSameDayAs: selectedDay)
            }
            .sorted { $0.startTime < $1.startTime }
    }
}
