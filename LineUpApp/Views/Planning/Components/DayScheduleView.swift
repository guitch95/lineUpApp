//
//  DayScheduleView.swift
//  LineUpApp
//
//  Created by Apprenant151 on 28/10/2026.
//

import SwiftUI

struct DayScheduleView: View {
    let reservations: [ReservationResponse]

    private let firstHour = 8
    private let lastHour = 24  // minuit
    private let hourHeight: CGFloat = 56
    private let labelWidth: CGFloat = 28
    private let spacing: CGFloat = 4

    private struct PlacedWorkshop: Identifiable {
        let reservation: ReservationResponse
        let column: Int
        let columnCount: Int
        var id: UUID { reservation.id }
    }

    var body: some View {
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

                            WorkshopCard(reservation: placed.reservation)
                                .frame(
                                    width: width,
                                    height: height(of: placed.reservation)
                                )
                                .offset(
                                    x: leading + CGFloat(placed.column)
                                        * (width + spacing),
                                    y: position(
                                        of: placed.reservation.startTimeWorkshop
                                    )
                                )
                        }
                    }
                }
                .overlay(alignment: .top) {
                    if reservations.isEmpty {
                        Text("Aucun atelier réservé ce jour-là")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .padding(.top, hourHeight * 2)
                    }
                }
        }
        .scrollIndicators(.hidden)
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
        var group: [(reservation: ReservationResponse, column: Int)] = []
        var columnEnds: [Date] = []

        func closeGroup() {
            placed += group.map {
                PlacedWorkshop(
                    reservation: $0.reservation,
                    column: $0.column,
                    columnCount: columnEnds.count
                )
            }
            group = []
            columnEnds = []
        }

        for reservation in reservations.sorted(by: {
            $0.startTimeWorkshop < $1.startTimeWorkshop
        }) {
            if let groupEnd = columnEnds.max(),
                reservation.startTimeWorkshop >= groupEnd
            {
                closeGroup()
            }
            if let freeColumn = columnEnds.firstIndex(where: {
                $0 <= reservation.startTimeWorkshop
            }) {
                columnEnds[freeColumn] = reservation.endTimeWorkshop
                group.append((reservation, freeColumn))
            } else {
                columnEnds.append(reservation.endTimeWorkshop)
                group.append((reservation, columnEnds.count - 1))
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

    private func height(of reservation: ReservationResponse) -> CGFloat {
        let hours =
            reservation.endTimeWorkshop.timeIntervalSince(
                reservation.startTimeWorkshop
            ) / 3600
        return hours * hourHeight - 8
    }
}

#Preview {
    DayScheduleView(reservations: ReservationResponse.samples)
        .padding()
        .background(Color.bg)
}
