//
//  PlanningView.swift
//  LineUpApp
//
//  Created by Guillaume Richard on 16/10/2026.
//

import SwiftUI

struct PlanningView: View {

    @State private var viewModel = PlanningViewModel()

    var body: some View {
        ZStack {
            Color.bg
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 20) {
                HeaderView()
                DaySelectorView(
                    days: viewModel.days,
                    selectedDay: $viewModel.selectedDay
                )
                WorkshopEmptyListView(
                    workshops: viewModel.workshopsForSelectedDay
                )
            }
            .padding()
            .task {
                await viewModel.loadWorkshops()
            }
        }
        
    }
}

#Preview {
    PlanningView()
}
