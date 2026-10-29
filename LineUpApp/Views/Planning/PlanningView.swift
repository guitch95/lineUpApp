//
//  PlanningView.swift
//  LineUpApp
//
//  Created by Guillaume Richard on 16/10/2026.
//

import SwiftUI

struct PlanningView: View {

    @Environment(AuthService.self) private var authService

    @State private var viewModelPlanning = PlanningViewModel()

    var body: some View {
        ZStack {
            Color.bg
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 20) {
                HeaderView(reservedCount: viewModelPlanning.reservedCount)
                DaySelectorView(
                    days: viewModelPlanning.days,
                    reservedDays: viewModelPlanning.reservedDays,
                    selectedDay: $viewModelPlanning.selectedDay
                )
                if let errorMessage = viewModelPlanning.errorMessage {
                    Text(errorMessage)
                        .font(.caption)
                        .foregroundStyle(.red)
                }
                DayScheduleView(
                    workshops: viewModelPlanning.workshopsForSelectedDay
                )
            }
            .padding()
            .task {
                await viewModelPlanning.loadPlanning(token: authService.token)
            }
        }

    }
}

#Preview {
    PlanningView()
        .environment(AuthService())
}
