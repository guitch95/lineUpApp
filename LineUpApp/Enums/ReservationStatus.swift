//
//  EnumReservation.swift
//  lineUpAPP
//
//  Created by Apprenant123 on 14/10/2026.
//

import Foundation

enum ReservationStatus: String, Codable, CaseIterable {
    case validee = "validée"
    case enAttente = "en attente"
    case annulee = "annulée"
}
