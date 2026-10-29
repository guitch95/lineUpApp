//
//  CategoryTag.swift
//  LineUpApp
//
//  Created by Canessane Ramya on 17/10/2026.
//

import SwiftUI

struct CategoryTag: View {
    let category: String
    var body: some View {
        Text(category)
            .textCase(.uppercase)
            .font(.system(size: 9))
            .fontWeight(.bold)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .foregroundStyle(.white)
            .background(.redBtn)
            .clipShape(Capsule())
    }
}

#Preview {
    CategoryTag(category: "voix")
}
