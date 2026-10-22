//
//  ProfileView.swift
//  LineUpApp
//
//  Created by Guillaume Richard on 16/10/2026.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        ZStack {
            Color.bg
            VStack(spacing: 20){
                HStack {
                    Text("Profil")
                        .bold()
                        .font(.title)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                Image(systemName: "person.fill")
                    .font(.largeTitle)

                Button {
                    print("hello")
                } label: {
                    Text("Se déconnecter")
                        .foregroundStyle(.redBtn)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(.white, in: .rect(cornerRadius: 12))
                }
                Spacer()
            }
            .padding(.top, 40)
            .padding(18)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ProfileView()
}
