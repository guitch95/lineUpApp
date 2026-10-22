//
//  PlanningView.swift
//  LineUpApp
//
//  Created by Guillaume Richard on 16/10/2026.
//

import SwiftUI

struct PlanningView: View {
    private let workshops = PlanningView.sampleWorkshops
    private let days = PlanningView.sampleDays

    @State private var selectedDay: Date = PlanningView.sampleDays.first ?? Date()

    var body: some View {
        ZStack {
            Color.bg
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 20) {
                header
                daySelector
                workshopList
            }
            .padding()
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Mon planning")
                .font(.system(.largeTitle, design: .serif, weight: .bold))

            Text("\(workshops.count) ateliers réservés sur le festival")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }

    private var daySelector: some View {
        HStack(spacing: 4) {
            ForEach(days, id: \.self) { day in
                DayButton(day: day, isSelected: day == selectedDay) {
                    selectedDay = day
                }
            }
        }
        .padding(6)
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(Color.primary.opacity(0.06))
        )
    }

    private var workshopsForSelectedDay: [Workshop] {
        workshops
            .filter { Calendar.current.isDate($0.startTime, inSameDayAs: selectedDay) }
            .sorted { $0.startTime < $1.startTime }
    }

    private var workshopList: some View {
        ScrollView {
            VStack(spacing: 12) {
                ForEach(workshopsForSelectedDay) { workshop in
                    WorkshopCard(workshop: workshop)
                }

                if workshopsForSelectedDay.isEmpty {
                    Text("Aucun atelier ce jour-là")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .padding(.top, 40)
                }
            }
        }
    }
}

private struct DayButton: View {
    let day: Date
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 6) {
                Text(day.formatted(.dateTime.weekday(.abbreviated)))
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Text(day.formatted(.dateTime.day()))
                    .font(.system(.title3, design: .serif, weight: .bold))
                    .foregroundStyle(isSelected ? Color.redBtn : Color.primary)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(isSelected ? Color.white : Color.clear)
            )
        }
        .buttonStyle(.plain)
    }
}

private struct WorkshopCard: View {
    let workshop: Workshop

    private var timeRange: String {
        "\(workshop.startTime.formatted(date: .omitted, time: .shortened)) - \(workshop.endTime.formatted(date: .omitted, time: .shortened))"
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(workshop.name)
                .font(.headline)

            Text(timeRange)
                .font(.subheadline)

            Label(workshop.category.name, systemImage: "mappin.and.ellipse")
                .font(.subheadline)
        }
        .foregroundStyle(.white)
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(Color.redBtn)
        )
    }
}

private extension PlanningView {
    static let sampleWorkshops: [Workshop] = {
        let calendar = Calendar.current

        func date(day: Int, hour: Int, minute: Int = 0) -> Date {
            calendar.date(from: DateComponents(year: 2026, month: 11, day: day, hour: hour, minute: minute)) ?? Date()
        }

        let expression = Category(id: UUID(), name: "Atelier Expression", workshops: [])
        let technique = Category(id: UUID(), name: "Atelier Technique", workshops: [])
        let improvisation = Category(id: UUID(), name: "Atelier Jeu", workshops: [])

        return [
            Workshop(
                id: UUID(),
                name: "Jeu masqué",
                startTime: date(day: 5, hour: 10),
                endTime: date(day: 5, hour: 12),
                capacityMax: 20,
                subscribersNb: 15,
                description: "",
                category: expression
            ),
            Workshop(
                id: UUID(),
                name: "Mise en lumière",
                startTime: date(day: 6, hour: 15),
                endTime: date(day: 6, hour: 17),
                capacityMax: 15,
                subscribersNb: 15,
                description: "",
                category: technique
            ),
            Workshop(
                id: UUID(),
                name: "Improvisation",
                startTime: date(day: 7, hour: 11),
                endTime: date(day: 7, hour: 12, minute: 30),
                capacityMax: 25,
                subscribersNb: 20,
                description: "",
                category: improvisation
            )
        ]
    }()

    static let sampleDays: [Date] = {
        let calendar = Calendar.current
        let days = Set(sampleWorkshops.map { calendar.startOfDay(for: $0.startTime) })
        return days.sorted()
    }()
}

#Preview {
    PlanningView()
}
