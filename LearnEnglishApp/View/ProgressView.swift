//
//  ProgressView.swift
//  LearnEnglishApp
//
//  Created by Тимур Нуртдинов on 07.05.2025.
//

import SwiftUI

struct ProgressView: View {
    @EnvironmentObject var userManager: UserManager
    @EnvironmentObject var localization: LocalizationManager

    enum Interval: String, CaseIterable, Identifiable {
        case day, week, month, all

        var id: String { self.rawValue }
    }

    @State private var selectedInterval: Interval = .day

    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                Picker("Interval", selection: $selectedInterval) {
                    Text(localization.localized("Today")).tag(Interval.day)
                    Text(localization.localized("Week")).tag(Interval.week)
                    Text(localization.localized("Month")).tag(Interval.month)
                    Text(localization.localized("AllTime")).tag(Interval.all)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)

                ProgressStatView(
                    title: localization.localized(selectedInterval.rawValue.capitalized),
                    count: learnedCount(for: selectedInterval),
                    color: .black,
                    suffix: localization.localized("Phrases")
                )

                Spacer()
            }
            .padding()
        }
    }

    private func learnedCount(for interval: Interval) -> Int {
        guard let history = userManager.currentUser?.learnedHistory else { return 0 }
        let fromDate = startDate(for: interval)
        return history.values.filter { $0 >= fromDate }.count
    }

    private func startDate(for interval: Interval) -> Date {
        let calendar = Calendar.current
        let now = Date()

        switch interval {
        case .day: return calendar.startOfDay(for: now)
        case .week: return calendar.date(byAdding: .day, value: -7, to: now)!
        case .month: return calendar.date(byAdding: .month, value: -1, to: now)!
        case .all: return Date.distantPast
        }
    }
}
struct ProgressStatView: View {
    let title: String
    let count: Int
    let color: Color
    let suffix: String

    var body: some View {
        HStack {
            Text(title)
                .font(.headline)

            Spacer()

            Text("\(count) \(suffix)")
                .font(.title3)
                .bold()
                .foregroundColor(color)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}
