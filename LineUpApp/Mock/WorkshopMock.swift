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

        let voixCategory = Category(
            id: UUID(),
            name: "Voix"
        )
        let improCategory = Category(
            id: UUID(),
            name: "Impro"
        )
        let miseEnSceneCategory = Category(
            id: UUID(),
            name: "Mise en scène"
        )

        return [
            Workshop(
                id: UUID(),
                name: "Maitrise de la voix",
                startTime: date(day: 6, hour: 19, minute: 0),
                endTime: date(day: 6, hour: 20, minute: 30),
                capacityMax: 15,
                subscribersNb: 15,
                description: "Explorez toute la puissance et la subtilité de votre organe vocal. À travers des exercices de respiration guidée, de placement de la voix et de résonance corporelle, vous apprendrez à projeter sans forcer et à captiver votre auditoire en toutes circonstances.",
                category: voixCategory
            ),
            Workshop(
                id: UUID(),
                name: "Lecture perchée",
                startTime: date(day: 6, hour: 13, minute: 30),
                endTime: date(day: 6, hour: 15, minute: 30),
                capacityMax: 15,
                subscribersNb: 12,
                description: "Un atelier immersif axé sur l'interprétation poétique et théâtrale. Apprenez à donner une dimension vivante et incarnée à n'importe quel texte, en jouant sur les nuances de rythmes, les silences et l'intention dramatique.",
                category: improCategory
            ),
            Workshop(
                id: UUID(),
                name: "Éloquence en scène",
                startTime: date(day: 7, hour: 21, minute: 0),
                endTime: date(day: 7, hour: 22, minute: 30),
                capacityMax: 25,
                subscribersNb: 14,
                description: "Domptez le trac et transformez vos prises de parole en moments de pure conviction. Cet atelier interactif propose des mises en situation scéniques pour structurer votre discours, affirmer votre posture et maîtriser l'art de la persuasion.",
                category: voixCategory
            ),
            Workshop(
                id: UUID(),
                name: "Corps & Récit",
                startTime: date(day: 7, hour: 16, minute: 0),
                endTime: date(day: 7, hour: 18, minute: 0),
                capacityMax: 20,
                subscribersNb: 13,
                description: "Quand le mouvement précède et enrichit la parole. En explorant la mémoire corporelle, l'espace scénique et la gestuelle spontanée, vous découvrirez comment raconter des histoires puissantes grâce à l'expressivité physique.",
                category: improCategory
            ),
            Workshop(
                id: UUID(),
                name: "Mise en lumière",
                startTime: date(day: 8, hour: 11, minute: 0),
                endTime: date(day: 8, hour: 13, minute: 0),
                capacityMax: 15,
                subscribersNb: 11,
                description: "Comprendre l'interaction intime entre l'acteur et l'éclairage théâtral. Expérimentez le jeu sous différentes atmosphères lumineuses et découvrez comment vous positionner par rapport aux projecteurs pour valoriser la mise en scène.",
                category: miseEnSceneCategory
            )
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

