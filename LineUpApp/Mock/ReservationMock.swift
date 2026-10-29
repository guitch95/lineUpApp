//
//  ReservationMock.swift
//  LineUpApp
//
//  Created by Apprenant151 on 29/10/2026.
//

import Foundation

extension ReservationResponse {
    static let samples: [ReservationResponse] = {
        let calendar = Calendar.current

        func date(day: Int, hour: Int, minute: Int = 0) -> Date {
            calendar.date(
                from: DateComponents(
                    year: 2026,
                    month: 11,
                    day: day,
                    hour: hour,
                    minute: minute
                )
            ) ?? Date()
        }

        func reservation(_ name: String, day: Int, start: Int, end: Int) -> ReservationResponse {
            ReservationResponse(
                id: UUID(),
                userID: UUID(),
                status: .validee,
                workshopID: UUID(),
                nameWorkshop: name,
                startTimeWorkshop: date(day: day, hour: start),
                endTimeWorkshop: date(day: day, hour: end)
            )
        }

        return [
            reservation("Mise en lumière", day: 7, start: 11, end: 13),
            reservation("Écriture de scène", day: 7, start: 14, end: 16),
            reservation("Initiation à la poterie", day: 7, start: 16, end: 18)
        ]
    }()
}
