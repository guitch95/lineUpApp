//
//  ProgrammeView.swift
//  LineUpApp
//
//  Created by Guillaume Richard on 16/10/2026.
//

import SwiftUI

struct ProgramView: View {
    @State private var vm = ProgramViewModel()
    @State private var selectedFeaturedIndex = 0
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 28) {
                    ScheduleHeaderView()
                    TabView(selection: $selectedFeaturedIndex) {
                        ForEach(Array(vm.featuredWorkshops.enumerated()), id: \.offset) { index, workshop in
                            NavigationLink(destination: WorkshopDetailView(viewModel: WorkshopDetailViewModel(workshop: workshop))) {
                                FeaturedWorkshopCard(
                                    workshop: workshop,
                                    numberOfPages: vm.featuredWorkshops.count,
                                    currentIndex: selectedFeaturedIndex
                                )
                                .tag(index)
                            }
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never)) 
                    .frame(height: 180)
                    
                    HStack {
                        DatePillPicker(availableDays: vm.availableDays, selectedDate: $vm.selectedDate)
                        Spacer()
                        FilterButton(selectedCategory: $vm.selectedCategory)
                    }
                    if vm.filteredWorkshops.isEmpty {
                        Spacer()
                        Text("Aucun atelier ne correspond à la date et à la catégorie sélectionnées.")
                            .foregroundStyle(.loginText)
                            .frame(maxWidth: .infinity)
                            .frame(minHeight: 400)
                        Spacer()
                    } else {
                        ForEach(vm.filteredWorkshops) { workshop in
                            EventRow(workshop: workshop)
                            Divider()
                        }
                    }
                }
                .padding()
                .task {
                    await vm.fetchWorkshops()
                }
            }
            .background(.bg)
        }
    }
}

#Preview {
    ProgramView()
}
