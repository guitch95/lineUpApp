//
//  Workshop+Mock.swift
//  LineUpApp
//
//  Created by Apprenant151 on 22/10/2026.
//

import Foundation

extension Workshop {
    static let samples: [Workshop] = {
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

        let expression = Category(
            id: UUID(),
            name: "Atelier Expression"
        )
        let technique = Category(
            id: UUID(),
            name: "Atelier Technique"
        )
        let improvisation = Category(
            id: UUID(),
            name: "Atelier Jeu"
        )

        return [
            Workshop(
                id: UUID(),
                name: "Jeu masqué",
                startTime: date(day: 5, hour: 10),
                endTime: date(day: 5, hour: 12),
                capacityMax: 20,
                subscribersNb: 15,
                description: "",
                category: expression,
                location: "Salle Molière",
                speaker: "Camille Durand"
            ),
            Workshop(
                id: UUID(),
                name: "Mise en lumière",
                startTime: date(day: 6, hour: 15),
                endTime: date(day: 6, hour: 17),
                capacityMax: 15,
                subscribersNb: 15,
                description: "",
                category: technique,
                location: "Salle Jouvet",
                speaker: "Julien Martin"
            ),
            Workshop(
                id: UUID(),
                name: "Improvisation",
                startTime: date(day: 7, hour: 11),
                endTime: date(day: 7, hour: 12, minute: 30),
                capacityMax: 25,
                subscribersNb: 20,
                description: "",
                category: improvisation,
                location: "Salle Vilar",
                speaker: "Sophie Bernard"
            ),
        ]
    }()

    static let sampleDays: [Date] = {
        let calendar = Calendar.current
        let days = Set(
            samples.map { calendar.startOfDay(for: $0.startTime) }
        )
        return days.sorted()
    }()
}
