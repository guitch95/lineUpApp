//
//  PlanningViewModel.swift
//  LineUpApp
//
//  Created by Guillaume Richard on 16/10/2026.
//

import Foundation
import Observation

@Observable  // Observable: the view updates when data changes
final class PlanningViewModel {

    private let reservationService: ReservationService  // Gets the reservations from the API
    var selectedDay: Date

    private static let festivalDays: [Date] = (6...8).compactMap {
        Calendar.current.date(
            from: DateComponents(year: 2026, month: 11, day: $0)
        )
    }

    var days: [Date] {
        Self.festivalDays
    }

    init(
        reservationService: ReservationService = ReservationService()
    ) {
        self.reservationService = reservationService
        let today = Calendar.current.startOfDay(for: Date())
        self.selectedDay =
            Self.festivalDays.contains(today) ? today : Self.festivalDays[0]
    }

    var errorMessage: String? {
        reservationService.errorMessage
    }

    private var reservationsWorkshops: [ReservationResponse] {  // Reservations of the user without the cancelled ones
        reservationService.reservations.filter { $0.status != .annulee }
    }

    var reservedDays: Set<Date> {  // Days where the user has at least one workshop
        let calendar = Calendar.current
        return Set(
            reservationsWorkshops.map {
                calendar.startOfDay(for: $0.startTimeWorkshop)
            }
        )
    }

    var reservedCount: Int {
        reservationsWorkshops.count
    }

    var reservationsForSelectedDay: [ReservationResponse] {  // Workshops of the selected day sorted by start time
        reservationsWorkshops
            .filter {
                Calendar.current.isDate(
                    $0.startTimeWorkshop,
                    inSameDayAs: selectedDay
                )
            }
            .sorted { $0.startTimeWorkshop < $1.startTimeWorkshop }
    }

    func loadPlanning(token: String?) async {  // Load the reservations (if token is present)
        guard let token else { return }
        await reservationService.fetchReservationsUser(token: token)
    }
}
