//
//  DayScheduleView.swift
//  LineUpApp
//
//  Created by Apprenant151 on 28/10/2026.
//

import SwiftUI

struct DayScheduleView: View {
    let workshops: [Workshop]

    private let firstHour = 8
    private let lastHour = 24  // minuit
    private let hourHeight: CGFloat = 56
    private let labelWidth: CGFloat = 28
    private let spacing: CGFloat = 4

    private struct PlacedWorkshop: Identifiable {
        let workshop: Workshop
        let column: Int
        let columnCount: Int
        var id: UUID { workshop.id }
    }

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                hourGrid
                    .overlay(alignment: .topLeading) {
                        GeometryReader { geometry in
                            let leading = labelWidth + spacing
                            let availableWidth = geometry.size.width - leading

                            ForEach(placedWorkshops) { placed in
                                let count = CGFloat(placed.columnCount)
                                let width =
                                    (availableWidth - spacing * (count - 1)) / count

                                WorkshopCard(workshop: placed.workshop)
                                    .frame(
                                        width: width,
                                        height: height(of: placed.workshop)
                                    )
                                    .offset(
                                        x: leading + CGFloat(placed.column)
                                            * (width + spacing),
                                        y: position(
                                            of: placed.workshop.startTime
                                        )
                                    )
                            }
                        }
                    }
                    .overlay(alignment: .top) {
                        if workshops.isEmpty {
                            Text("Aucun atelier réservé ce jour-là")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                                .padding(.top, hourHeight * 2)
                        }
                    }
            }
            .scrollIndicators(.hidden)
            .onAppear { scrollToFirstWorkshop(proxy) }
            .onChange(of: workshops.map(\.id)) {
                withAnimation { scrollToFirstWorkshop(proxy) }
            }
        }
    }

    // Heure du premier atelier réservé du jour (nil si aucun)
    private var firstWorkshopHour: Int? {
        workshops
            .map(\.startTime)
            .min()
            .map { Calendar.current.component(.hour, from: $0) }
    }

    // Scrolle une heure avant le premier atelier pour garder du contexte
    private func scrollToFirstWorkshop(_ proxy: ScrollViewProxy) {
        let hour = firstWorkshopHour.map { max($0 - 1, firstHour) } ?? firstHour
        proxy.scrollTo(hour, anchor: .top)
    }

    private var hourGrid: some View {
        VStack(spacing: 0) {
            ForEach(firstHour...lastHour, id: \.self) { hour in
                HStack(alignment: .top, spacing: 0) {
                    Text("\(hour % 24)h")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                        .frame(width: labelWidth, alignment: .leading)
                        .padding(.top, 2)

                    ZStack(alignment: .top) {
                        gridLine(opacity: 0.08)
                        gridLine(opacity: 0.04)
                            .offset(y: hourHeight / 2)
                    }
                }
                .frame(height: hourHeight, alignment: .top)
                .id(hour)
            }
        }
    }

    private func gridLine(opacity: Double) -> some View {
        Rectangle()
            .fill(Color.primary.opacity(opacity))
            .frame(height: 1)
    }

    private var placedWorkshops: [PlacedWorkshop] {
        var placed: [PlacedWorkshop] = []
        var group: [(workshop: Workshop, column: Int)] = []
        var columnEnds: [Date] = []

        func closeGroup() {
            placed += group.map {
                PlacedWorkshop(
                    workshop: $0.workshop,
                    column: $0.column,
                    columnCount: columnEnds.count
                )
            }
            group = []
            columnEnds = []
        }

        for workshop in workshops.sorted(by: {
            $0.startTime < $1.startTime
        }) {
            if let groupEnd = columnEnds.max(),
                workshop.startTime >= groupEnd
            {
                closeGroup()
            }
            if let freeColumn = columnEnds.firstIndex(where: {
                $0 <= workshop.startTime
            }) {
                columnEnds[freeColumn] = workshop.endTime
                group.append((workshop, freeColumn))
            } else {
                columnEnds.append(workshop.endTime)
                group.append((workshop, columnEnds.count - 1))
            }
        }
        closeGroup()
        return placed
    }

    private func position(of date: Date) -> CGFloat {
        let time = Calendar.current.dateComponents(
            [.hour, .minute],
            from: date
        )
        let hours =
            Double((time.hour ?? firstHour) - firstHour) + Double(
                time.minute ?? 0
            ) / 60
        return hours * hourHeight
    }

    private func height(of workshop: Workshop) -> CGFloat {
        let hours =
            workshop.endTime.timeIntervalSince(
                workshop.startTime
            ) / 3600
        return hours * hourHeight - 8
    }
}

#Preview {
    DayScheduleView(workshops: Workshop.samples)
        .padding()
        .background(Color.bg)
}
