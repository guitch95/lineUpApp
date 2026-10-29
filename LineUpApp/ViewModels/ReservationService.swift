//
//  ReservationService.swift
//  LineUpApp
//
//  Created by Apprenant151 on 27/10/2026.

import Foundation

@Observable  // the view updates when data changes
final class ReservationService {

    private(set) var reservations: [ReservationResponse] = []  // List of the users reservations
    var errorMessage: String?

    private let baseURL = URL(string: "http://127.0.0.1:8080")!

    func fetchReservationsUser(token: String) async {
        errorMessage = nil
        var request = URLRequest(
            url: baseURL.appending(path: "reservations/me")
        )

        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")  // Send the token to prove who the user is

        do {

            let (data, response) = try await URLSession.shared.data(  // Call the server and wait for the answer
                for: request
            )

            // Check that the answer is a valid HTTP response
            guard let http = response as? HTTPURLResponse else {
                errorMessage = "Réponse invalide du serveur"
                return
            }

            switch http.statusCode {
            case 200:  // success = convert JSON to ReservationResponse objects
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                reservations = try decoder.decode(
                    [ReservationResponse].self,
                    from: data
                )
            case 401:
                errorMessage = "Session expirée, reconnectez-vous"
            default:
                errorMessage = "Impossible de contacter le serveur"
            }

        } catch {
            print(error)
        }
    }
}
