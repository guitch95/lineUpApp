//
//  LoginView.swift
//  LineUpApp
//
//  Created by Guillaume Richard on 16/10/2026.
//

import SwiftUI

struct LoginView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var selected = "connexion"
    var body: some View {
        ZStack {
            Color.bg
            VStack(spacing: 30){
                VStack(spacing: 30){
                    Image(.logoIcon)

                    VStack {
                        Text("LineUp")
                            .font(.title)
                            .bold()
                        Text("Festival · Paris · 5–7 Sept 2026")
                            .foregroundStyle(.loginText)
                    }
                }
                .padding(.top, 60)
                .padding(.bottom, 30)

                HStack {
                    Button {
                        selected = "connexion"
                    } label: {
                        Text("Connexion")
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(
                                selected == "connexion" ? .white : .bgColorPicker,
                                in: .rect(cornerRadius: 8)
                            )
                            .foregroundStyle(selected == "connexion" ? .black : .loginText)
                    }
                    .animation(.smooth(duration: 0.5), value: selected)

                    Button {
                        selected = "inscription"

                    } label: {
                        Text("Inscription")
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(selected == "inscription" ? .white : .bgColorPicker, in: .rect(cornerRadius: 8))
                            .foregroundStyle(selected == "inscription" ? .black : .loginText)
                    }
                    .animation(.smooth(duration: 0.5), value: selected)

                }
                .frame(maxWidth: .infinity)
                .padding(5)
                .background(.bgColorPicker, in: .rect(cornerRadius: 12))

                VStack(alignment: .leading){
                    Text("Adresse Email")
                        .font(.caption)
                        .foregroundStyle(.loginText)
                        .textCase(.uppercase)
                    TextField("Veuillez entrer votre email", text: $email)
                        .padding()
                        .frame(height: 55)
                        .background(.white, in: .rect(cornerRadius: 12))

                }
                VStack(alignment: .leading){
                    Text("Mot de passe")
                        .font(.caption)
                        .foregroundStyle(.loginText)
                        .textCase(.uppercase)
                    SecureField("Veuillez saisir votre mot de passe", text: $password)
                        .padding()
                        .frame(height: 55)
                        .background(.white, in: .rect(cornerRadius: 12))
                }
                Button {
                    print("Hello")
                } label: {
                    Text("Se connecter")
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(.redBtn, in: .rect(cornerRadius: 12))
                        .foregroundStyle(.white)
                }
                Spacer()
            }
            .padding(18)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    LoginView()
}
