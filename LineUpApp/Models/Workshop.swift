//
//  Workshop.swift
//  LineUpApp
//
//  Created by Apprenant151 on 21/10/2026.
//

import Foundation

struct Workshop: Identifiable {
    
    let id: UUID
    let name: String
    let startTime: Date
    let endTime: Date
    let capacityMax: Int
    let subscribersNb: Int
    let description: String
    let category: Category
}

extension Workshop {
    static func makeDate(hour: Int, minute: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(bySettingHour: hour, minute: minute, second: 0, of: Date()) ?? Date()
    }
    
    struct MockData {
        let workshop: Workshop
        let authorName: String
        let place: String
    }
    
    static let mockList: [MockData] = [
        MockData(
            workshop: Workshop(
                id: UUID(),
                name: "Maîtrise de la voix",
                startTime: makeDate(hour: 19, minute: 0),
                endTime: makeDate(hour: 20, minute: 30),
                capacityMax: 10,
                subscribersNb: 9,
                description: "Atelier vocal complet.",
                category: Category(id: UUID(), name: "VOIX")
            ),
            authorName: "Collectif La Voix Haute",
            place: "Cour des Célestins"
        ),
        MockData(
            workshop: Workshop(
                id: UUID(),
                name: "Improvisation Jazz",
                startTime: makeDate(hour: 14, minute: 0),
                endTime: makeDate(hour: 16, minute: 0),
                capacityMax: 12,
                subscribersNb: 12,
                description: "Session d'improvisation.",
                category: Category(id: UUID(), name: "MUSIQUE")
            ),
            authorName: "Marcus Delacroix",
            place: "Scène Beckett"
        ),
        MockData(
            workshop: Workshop(
                id: UUID(),
                name: "Lecture perchée",
                startTime: makeDate(hour: 14, minute: 30),
                endTime: makeDate(hour: 15, minute: 30),
                capacityMax: 28,
                subscribersNb: 7,
                description: "Lecture théâtralisée.",
                category: Category(id: UUID(), name: "THÉÂTRE")
            ),
            authorName: "Isabelle Moreau",
            place: "Studio Artaud"
        )
    ]
}
