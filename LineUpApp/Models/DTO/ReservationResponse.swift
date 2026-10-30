//
//  ReservationResponse.swift
//  LineUpApp
//
//  Created by Apprenant151 on 27/10/2026.
//

import Foundation

struct ReservationResponse: Identifiable, Decodable {
    let id: UUID
    let userID: UUID
    let status: ReservationStatus
    let workshopID: UUID
    let nameWorkshop: String
    let startTimeWorkshop: Date
    let endTimeWorkshop: Date
}

