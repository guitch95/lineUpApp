//
//  LoginView.swift
//  LineUpApp
//
//  Created by Guillaume Richard on 16/10/2026.
//

import SwiftUI

struct LoginView: View {

    @Environment(AuthService.self) private var authService
    @State private var email = ""
    @State private var password = ""

    var body: some View {
        VStack(spacing: 30) {
            VStack(alignment: .leading) {
                Text("Adresse Email")
                    .font(.caption)
                    .foregroundStyle(.loginText)
                    .textCase(.uppercase)
                TextField("Veuillez entrer votre email", text: $email)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .keyboardType(.emailAddress)
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
                Text("Se connecter")
                    .frame(maxWidth: .infinity)
                    .bold()
                    .frame(height: 55)
                    .background(.redBtn, in: .rect(cornerRadius: 12))
                    .foregroundStyle(.white)
            }
            if let errorMessage = authService.errorMessage {
                Text(errorMessage)
                    .font(.caption)
                    .foregroundStyle(.red)
            }
            Spacer()
        }
    }
}

#Preview {
    LoginView()
        .environment(AuthService())
}
