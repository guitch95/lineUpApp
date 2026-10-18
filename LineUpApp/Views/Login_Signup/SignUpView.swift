//
//  SignUpView.swift
//  LineUpApp
//
//  Created by Guillaume Richard on 16/10/2026.
//

import SwiftUI

struct SignUpView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var name: String = ""
    @State var selected = "connexion"
    var body: some View {
        VStack(spacing: 30) {
            VStack(alignment: .leading) {
                Text("Nom Complet")
                    .font(.caption)
                    .foregroundStyle(.loginText)
                    .textCase(.uppercase)
                TextField("Veuillez entrer votre nom", text: $email)
                    .textInputAutocapitalization(.never)
                    .padding()
                    .frame(height: 55)
                    .background(.white, in: .rect(cornerRadius: 12))

            }
            VStack(alignment: .leading) {
                Text("Adresse Email")
                    .font(.caption)
                    .foregroundStyle(.loginText)
                    .textCase(.uppercase)
                TextField("Veuillez entrer votre email", text: $email)
                    .textInputAutocapitalization(.never)
                    .padding()
                    .frame(height: 55)
                    .background(.white, in: .rect(cornerRadius: 12))

            }
            VStack(alignment: .leading) {
                Text("Mot de passe")
                    .font(.caption)
                    .foregroundStyle(.loginText)
                    .textCase(.uppercase)
                SecureField(
                    "Veuillez saisir votre mot de passe",
                    text: $password
                )
                .padding()
                .frame(height: 55)
                .background(.white, in: .rect(cornerRadius: 12))
            }
            Button {
                print("Hello")
            } label: {
                Text("Créer mon compte")
                    .frame(maxWidth: .infinity)
                    .bold()
                    .frame(height: 55)
                    .background(.redBtn, in: .rect(cornerRadius: 12))
                    .foregroundStyle(.white)
            }
            Spacer()
        }
    }

}

#Preview {
    SignUpView()
}

#Preview {
    MainView()
}
