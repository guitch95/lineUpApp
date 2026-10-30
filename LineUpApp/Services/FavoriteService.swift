//
//  FavoriteService.swift
//  LineUpApp
//
//  Created by Guillaume Richard on 29/10/2026.
//

import Foundation
import Observation

@Observable  // the views update when the favorites change
final class FavoriteService {

    private let favoritesKey = "favoriteWorkshopIDs"

    // Ids of the favorite workshops, saved on the device
    private(set) var favoriteIDs: [UUID] {
        didSet {
            UserDefaults.standard.set(
                favoriteIDs.map(\.uuidString),
                forKey: favoritesKey
            )
        }
    }

    init() {
        let saved = UserDefaults.standard.stringArray(forKey: favoritesKey) ?? []
        favoriteIDs = saved.compactMap(UUID.init(uuidString:))
    }

    func isFavorite(_ workshop: Workshop) -> Bool {
        favoriteIDs.contains(workshop.id)
    }

    func toggle(_ workshop: Workshop) {
        if favoriteIDs.contains(workshop.id) {
            favoriteIDs.removeAll { $0 == workshop.id }
        } else {
            favoriteIDs.append(workshop.id)
        }
    }
}
