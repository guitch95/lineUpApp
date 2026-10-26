//
//  WorkshopService.swift
//  LineUpApp
//
//  Created by Apprenant151 on 25/10/2026.
//

import Foundation

@Observable
final class WorkshopService {
    private(set) var workshops: [Workshop] = []  // stocke les ateliers récupérés
    var errorAlert: String?
    var isLoading = false

    private let baseURL = URL(string: "http://127.0.0.1:8080")!

    func fetchWorkshops() async {
        isLoading = true
        defer {
            isLoading = false
        }
        errorAlert = nil

        let url = baseURL.appending(path: "workshops")

        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            print(String(data: data, encoding: .utf8) ?? "")

            guard let http = response as? HTTPURLResponse,
                http.statusCode == 200
            else {
                errorAlert = "Erreur du chargement des workshops"
                return
            }

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            workshops = try decoder.decode([Workshop].self, from: data)
        } catch {
            errorAlert = "Pas de connexion au serveur"
        }
    }
}
