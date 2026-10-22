//
//  WorkshopTest.swift
//  LineUpApp
//
//  Created by Apprenant123 on 21/10/2026.
//

import Foundation

struct WorkshopTest: Identifiable {
    let id: UUID
    let location: String?
    let speaker: String?
}
extension WorkshopTest {
    static let mock = WorkshopTest(
        id: UUID(),
        location: "Salle Capucine - Étage 1",
        speaker: "Sophie Martin"
    )
    
    static let mockList: [WorkshopTest] = [
        WorkshopTest(id: UUID(), location: "Amphi A", speaker: "Alexandre Dev"),
        WorkshopTest(id: UUID(), location: "Atelier 2", speaker: "Claire Dubois")
    ]
}
    
