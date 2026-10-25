//
//  Workshop+Mock.swift
//  LineUpApp
//
//  Created by Apprenant151 on 22/10/2026.
//

import Foundation

extension Workshop {
    static let locations: [String: String] = [
        "Maitrise de la voix": "Cours des Célestins",
        "Lecture perchée": "Studio Artaud",
        "Éloquence en scène": "Salle Comédie",
        "Corps & Récit": "Cours des Arts",
        "Mise en lumière": "Atelier technique",
        "Jeu masqué": "Salle Molière",
        "Improvisation": "Salle Vilar",
    ]

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
            name: "Atelier Expression",
        )
        let technique = Category(
            id: UUID(),
            name: "Atelier Technique",
        )
        let improvisation = Category(
            id: UUID(),
            name: "Atelier Jeu",
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
                category: expression
            ),
            Workshop(
                id: UUID(),
                name: "Mise en lumière",
                startTime: date(day: 6, hour: 15),
                endTime: date(day: 6, hour: 17),
                capacityMax: 15,
                subscribersNb: 15,
                description: "",
                category: technique
            ),
            Workshop(
                id: UUID(),
                name: "Improvisation",
                startTime: date(day: 7, hour: 11),
                endTime: date(day: 7, hour: 12, minute: 30),
                capacityMax: 25,
                subscribersNb: 20,
                description: "",
                category: improvisation
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
