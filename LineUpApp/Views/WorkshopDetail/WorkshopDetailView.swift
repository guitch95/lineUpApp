//
//  WorkshopDetail.swift
//  LineUpApp
//
//  Created by Apprenant123 on 21/10/2026.
//

import SwiftUI

struct WorkshopDetailView: View {
    // On injecte notre modèle de test pour que la vue puisse l'afficher
    var workshop: WorkshopTest

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // TODO: Image de l'atelier
                
                // Titre et informations principales
                Text("Détails de l'atelier")
                    .font(.largeTitle)
                    .bold()
                
                // Affichage du lieu et de l'intervenant (grâce à notre modèle test !)
                if let location = workshop.location {
                    Label(location, systemImage: "mappin.and.ellipse")
                        .foregroundColor(.secondary)
                }
                
                if let speaker = workshop.speaker {
                    Label(speaker, systemImage: "person.fill")
                        .foregroundColor(.secondary)
                }
                
                Spacer()
            }
            .padding()
        }
        .background(Color("bgColor").ignoresSafeArea()) // Application de votre couleur de fond personnalisée
    }
}

#Preview {
    WorkshopDetailView(workshop: WorkshopTest.mock)
}
