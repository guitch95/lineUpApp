//
//  RecommendationService.swift
//  LineUpApp
//
//  Created by Guillaume Richard on 29/10/2026.
//

import Foundation
import FoundationModels

final class RecommendationService {
    private(set) var suggestions: [Suggestion] = []
    private(set) var isLoading = false
    var errorMessage: String?

    private let instructions = """
        Tu es l'assistant du festival de théâtre LineUp. \
        Tu aides un festivalier à choisir parmi les ateliers proposés. \
        Tu recommandes uniquement des ateliers présents dans la liste fournie, jamais d'autres. \
        Tu tiens compte de ses envies, de son niveau et de ses disponibilités. \
        Tu réponds en français, avec un ton chaleureux.
        """

    func recommend(for request: String, among workshops: [Workshop]) async {
        let request = request.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !request.isEmpty else { return }

        errorMessage = nil
        suggestions = []
        isLoading = true
        defer { isLoading = false }

        // Garanti par le code, pas confié au modèle
        let available = workshops.filter { !$0.isFull }
        guard !available.isEmpty else {
            errorMessage = "Tous les ateliers sont complets."
            return
        }

        let prompt = """
            Ateliers disponibles :
            \(available.map(\.promptLine).joined(separator: "\n"))

            Demande du festivalier : \(request)
            """

        // Une session neuve par demande : pas d'historique qui remplit le contexte
        let session = LanguageModelSession(instructions: instructions)

        do {
            let stream = session.streamResponse(to: prompt, generating: Recommendation.self)

            // Chaque snapshot contient toute la réponse générée jusqu'ici, propriétés optionnelles
            for try await snapshot in stream {
                let partial = snapshot.content.suggestions ?? []
                suggestions = partial.enumerated().map { index, item in
                    let name = item.workshopName ?? ""
                    return Suggestion(
                        id: index,
                        name: name,
                        reason: item.reason ?? "",
                        workshop: findWorkshop(named: name, in: available)
                    )
                }
            }

            // Fin du flux : on ne garde que les vrais ateliers, sans doublon
            var seen = Set<UUID>()
            suggestions = suggestions.filter { suggestion in
                guard let workshop = suggestion.workshop else { return false }
                return seen.insert(workshop.id).inserted
            }
            if suggestions.isEmpty {
                errorMessage = "Aucun atelier ne correspond, essaie de reformuler ta demande."
            }
        } catch let error as LanguageModelError {
            switch error {
            case .guardrailViolation, .refusal:
                errorMessage = "Je ne peux pas répondre à cette demande. Essaie de la formuler autrement."
            case .contextSizeExceeded:
                errorMessage = "La demande est trop longue."
            case .unsupportedLanguageOrLocale:
                errorMessage = "Cette langue n'est pas prise en charge."
            default:
                errorMessage = "L'assistant n'a pas pu répondre. Réessaie dans un instant."
            }
        } catch {
            errorMessage = "L'assistant n'a pas pu répondre. Réessaie dans un instant."
        }
    }

    /// Le vrai atelier qui porte ce nom, ou nil (nom incomplet ou inventé).
    /// Tolère les ajouts autour du nom : "Atelier : Poser sa voix sur scène (Théâtre)" → Poser sa voix sur scène
    private func findWorkshop(named name: String, in workshops: [Workshop]) -> Workshop? {
        let target = normalize(name)
        guard !target.isEmpty else { return nil }
        return workshops
            .filter { target.contains(normalize($0.name)) }
            .max { $0.name.count < $1.name.count }   // le nom le plus long l'emporte
    }

    /// "  art Mimique." et "Art mimique" doivent correspondre
    private func normalize(_ text: String) -> String {
        text.folding(options: [.caseInsensitive, .diacriticInsensitive], locale: Locale(identifier: "fr_FR"))
            .trimmingCharacters(in: .whitespacesAndNewlines.union(.punctuationCharacters))
    }
}
