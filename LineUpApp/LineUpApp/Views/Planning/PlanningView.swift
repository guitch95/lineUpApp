//
//  PlanningView.swift
//  LineUpApp
//
//  Created by Guillaume Richard on 16/10/2026.
//

import SwiftUI

struct PlanningView: View {
    @State private var viewModel = PlanningViewModel()

    private let hauteurHeure: CGFloat = 64

    var body: some View {
        ZStack {
            Color.bg

            VStack(alignment: .leading, spacing: 20) {
                enTete
                selecteurDeJours
                grilleHoraire
            }
            .padding(.horizontal)
            .padding(.top)
        }
        .ignoresSafeArea()
    }

    private var enTete: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Mon planning")
                .font(.system(.largeTitle, design: .serif, weight: .bold))

            Text("\(viewModel.nombreReservations) ateliers réservés sur le festival")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }

    private var selecteurDeJours: some View {
        HStack(spacing: 4) {
            ForEach(viewModel.joursDuFestival, id: \.self) { jour in
                JourBouton(
                    jour: jour,
                    estSelectionne: jour == viewModel.jourSelectionne,
                    aUneReservation: viewModel.aUneReservation(le: jour)
                ) {
                    viewModel.jourSelectionne = jour
                }
            }
        }
        .padding(6)
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(Color.primary.opacity(0.06))
        )
    }

    private var grilleHoraire: some View {
        ScrollView {
            ZStack(alignment: .topLeading) {
                VStack(spacing: 0) {
                    ForEach(Array(viewModel.plageHoraire), id: \.self) { heure in
                        LigneHeure(heure: heure)
                            .frame(height: hauteurHeure, alignment: .top)
                    }
                }

                ForEach(viewModel.reservations(pour: viewModel.jourSelectionne)) { reservation in
                    CarteReservation(
                        titre: reservation.titreAtelier,
                        lieu: reservation.lieu,
                        texteHoraire: viewModel.texteHoraire(reservation)
                    )
                    .padding(.leading, 44)
                    .frame(height: hauteurHeure * viewModel.dureeEnHeures(reservation), alignment: .top)
                    .offset(y: hauteurHeure * (viewModel.heureDecimale(reservation.dateDebut) - Double(viewModel.plageHoraire.lowerBound)))
                }
            }
        }
    }
}

private struct JourBouton: View {
    let jour: Date
    let estSelectionne: Bool
    let aUneReservation: Bool
    let action: () -> Void

    private static let formatteurJour: DateFormatter = {
        let formatteur = DateFormatter()
        formatteur.locale = Locale(identifier: "fr_FR")
        formatteur.dateFormat = "EEE"
        return formatteur
    }()

    private var abreviationJour: String {
        Self.formatteurJour.string(from: jour)
            .replacingOccurrences(of: ".", with: "")
            .capitalized
    }

    var body: some View {
        Button(action: action) {
            VStack(spacing: 6) {
                Text(abreviationJour)
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Text(jour.formatted(.dateTime.day()))
                    .font(.system(.title3, design: .serif, weight: .bold))
                    .foregroundStyle(estSelectionne ? Color.redBtn : Color.primary)

                Circle()
                    .fill(Color.redBtn.opacity(aUneReservation ? 0.6 : 0))
                    .frame(width: 5, height: 5)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(estSelectionne ? Color.white : Color.clear)
                    .shadow(color: .black.opacity(estSelectionne ? 0.08 : 0), radius: 4, y: 2)
            )
        }
        .buttonStyle(.plain)
    }
}

private struct LigneHeure: View {
    let heure: Int

    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Text("\(heure)h")
                .font(.caption)
                .foregroundStyle(.secondary)
                .frame(width: 32, alignment: .trailing)

            VStack(spacing: 0) {
                Divider()
                Spacer(minLength: 0)
            }
        }
    }
}

private struct CarteReservation: View {
    let titre: String
    let lieu: String
    let texteHoraire: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(titre)
                .font(.headline)

            Text(texteHoraire)
                .font(.subheadline)

            Label(lieu, systemImage: "mappin.and.ellipse")
                .font(.subheadline)
        }
        .foregroundStyle(.white)
        .padding(12)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(Color.redBtn)
        )
        .overlay(alignment: .leading) {
            RoundedRectangle(cornerRadius: 2)
                .fill(Color.yellow)
                .frame(width: 4)
                .padding(.vertical, 10)
                .padding(.leading, 4)
        }
    }
}

#Preview {
    PlanningView()
}
