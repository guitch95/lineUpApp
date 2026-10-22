//
//  SignUpView.swift
//  LineUpApp
//
//  Created by Guillaume Richard on 16/10/2026.
//

import SwiftUI

struct SignUpView: View {

    @Environment(AuthService.self) private var authService
    @State private var email = ""
    @State private var password = ""
    @State private var name = ""

    var body: some View {
        VStack(spacing: 30) {
            VStack(alignment: .leading) {
                Text("Nom Complet")
                    .font(.caption)
                    .foregroundStyle(.loginText)
                    .textCase(.uppercase)
                TextField("Veuillez entrer votre nom", text: $name)
                    .textInputAutocapitalization(.words)
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
                    .keyboardType(.emailAddress)
                    .autocorrectionDisabled()
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
            if let errorMessage = authService.errorMessage {
                Text(errorMessage)
                    .font(.caption)
                    .foregroundStyle(.red)
            }
            Button {
                Task {
                    await authService.register(name: name, email: email, password: password)
                }
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
        .environment(AuthService())
}
