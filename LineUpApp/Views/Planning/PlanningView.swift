//
//  PlanningView.swift
//  LineUpApp
//
//  Created by Guillaume Richard on 16/10/2026.
//

import SwiftUI

struct PlanningView: View {

    @State private var viewModel = PlanningViewModel(
        workshops: Workshop.samples
    )

    var body: some View {
        ZStack {
            Color.bg
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 20) {
                HeaderView()
                DaySelectorView(
                    days: Workshop.sampleDays,
                    selectedDay: $viewModel.selectedDay
                )
                WorkshopEmptyListView(
                    workshops: viewModel.workshopsForSelectedDay
                )
            }
            .padding()
        }
        
    }
}

#Preview {
    PlanningView()
}
