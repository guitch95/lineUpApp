//
//  WorkshopService.swift
//  LineUpApp
//
//  Created by Canessane Ramya on 25/10/2026.
//

import Foundation

@Observable
final class WorkshopService {
    private(set) var workshops: [Workshop] = []
    var errorMessage: String?
    
    private let baseURL = URL(string: "http://127.0.0.1:8080")!
    
    func fetchWorkshops() async {
        errorMessage = nil
        let url = baseURL.appending(path: "workshops")
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let http = response as? HTTPURLResponse,
                  http.statusCode == 200
            else {
                errorMessage = "Impossible de charger les ateliers"
                return
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            let fetchedWorkshops = try decoder.decode([Workshop].self, from: data)
            
            self.workshops = fetchedWorkshops
            
        } catch {
            errorMessage = "Impossible de contacter le serveur"
        }
    }
}
