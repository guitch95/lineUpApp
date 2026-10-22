//
//  AuthService.swift
//  LineUpApp
//
//  Created by Guillaume Richard on 22/10/2026.
//

import Foundation
import Observation

@Observable
final class AuthService {
    private(set) var user: UserResponse?
    private(set) var isLoading = false
    var errorMessage: String?
    var isLoggedIn: Bool { user != nil }

    private let baseURL = URL(string: "http://127.0.0.1:8080")!
    private let tokenKey = "authToken"

    // Inscription (POST /users) puis connecte automatiquement l'utilisateur
    func register(name: String, email: String, password: String) async {
        errorMessage = nil
        isLoading = true
        defer { isLoading = false }
        do {
            var request = URLRequest(url: baseURL.appending(path: "users"))
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try JSONEncoder().encode(
                RegisterRequest(name: name, email: email, password: password)
            )

            let (_, response) = try await URLSession.shared.data(for: request)

            guard let http = response as? HTTPURLResponse else {
                errorMessage = "Réponse invalide du serveur."
                return
            }

            switch http.statusCode {
            case 200:
                // Connecte ici 
                await login(email: email, password: password)
            case 409:
                errorMessage = "Cet email est déjà utilisé."
            case 400:
                errorMessage = "Vérifiez vos informations de connexion."
            default:
                errorMessage = "Une erreur est survenue (\(http.statusCode))."
            }
        } catch {
            errorMessage = "Impossible de contacter le serveur."
        }
    }

    func login(email: String, password: String) async {
        errorMessage = nil
        isLoading = true
        defer { isLoading = false }
        do {
            var request = URLRequest(url: baseURL.appending(path: "auth/login"))
            request.httpMethod = "POST"
            request.setValue(
                "application/json",
                forHTTPHeaderField: "Content-Type"
            )
            request.httpBody = try JSONEncoder().encode(
                LoginRequest(email: email, password: password)
            )

            let (data, response) = try await URLSession.shared.data(
                for: request
            )

            guard let http = response as? HTTPURLResponse,
                http.statusCode == 200
            else {
                errorMessage = "Email ou mot de passe incorrect."
                return
            }

            let tokenResponse = try JSONDecoder().decode(
                TokenResponse.self,
                from: data
            )
            UserDefaults.standard.set(tokenResponse.token, forKey: tokenKey)
             await fetchMe()
        } catch {
            errorMessage = "Impossible de contacter le serveur."
        }
    }

    func fetchMe() async {
        guard let token = UserDefaults.standard.string(forKey: tokenKey) else {
            return
        }
        do {
            var request = URLRequest(url: baseURL.appending(path: "auth/me"))
            // Méthode GET par défaut
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            let (data, response) = try await URLSession.shared.data(for: request)

            // 3. Token expiré ou invalide → déconnexion
            guard let http = response as? HTTPURLResponse, http.statusCode == 200 else {
                logout()
                return
            }

            user = try JSONDecoder().decode(UserResponse.self, from: data)

        } catch {
            errorMessage = "Impossible de contacter le serveur."
        }
    }

    func restoreSession() async {
        await fetchMe()
    }

    func logout() {
        Task {
            try? await Task.sleep(for: .seconds(1))
            UserDefaults.standard.removeObject(forKey: tokenKey)
            user = nil
        }
    }
}
