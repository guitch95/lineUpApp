//
//  MainView.swift
//  LineUpApp
//
//  Created by Guillaume Richard on 18/10/2026.
//

import SwiftUI

struct MainView: View {
    @Environment(AuthService.self) private var authService
    @State private var selected = "connexion"
    var body: some View {
        ZStack {
            Color.bg
            VStack(spacing: 30) {
                VStack {
                    Image(.logoIcon)
                        .padding(.top, 50)
                    VStack {
                        Text("LineUp")
                            .font(.title)
                            .bold()
                        Text("Festival · Naples · 6–8 Novembre 2026")
                            .foregroundStyle(.loginText)
                    }
                }
                .padding(.bottom, 30)

                HStack {
                    Button {
                        selected = "connexion"
                        authService.errorMessage = nil
                    } label: {
                        Text("Connexion")
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(
                                selected == "connexion"
                                    ? .white : .bgColorPicker,
                                in: .rect(cornerRadius: 8)
                            )
                            .foregroundStyle(
                                selected == "connexion" ? .black : .loginText
                            )
                    }
                    .animation(.smooth(duration: 0.5), value: selected)

                    Button {
                        selected = "inscription"
                        authService.errorMessage = nil

                    } label: {
                        Text("Inscription")
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(
                                selected == "inscription"
                                    ? .white : .bgColorPicker,
                                in: .rect(cornerRadius: 8)
                            )
                            .foregroundStyle(
                                selected == "inscription" ? .black : .loginText
                            )
                    }
                    .animation(.smooth(duration: 0.5), value: selected)

                }
                .frame(maxWidth: .infinity)
                .padding(5)
                .background(.bgColorPicker, in: .rect(cornerRadius: 12))

                if selected == "connexion" {
                    LoginView()
                } else {
                    SignUpView()
                }
            }
            .padding(18)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    MainView()
        .environment(AuthService())
}
