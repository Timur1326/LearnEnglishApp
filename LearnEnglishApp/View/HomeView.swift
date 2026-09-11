//
//  HomeView.swift
//  LearnEnglishApp
//
//  Created by Тимур Нуртдинов on 07.05.2025.
//


import SwiftUI

enum TopicSortOption: String, CaseIterable, Identifiable {
    case alphabetical = "По алфавиту"
    case progress = "По прогрессу"

    var id: String { rawValue }
}

struct HomeView: View {
    @EnvironmentObject var viewModel: TopicViewModel
    @EnvironmentObject var localization: LocalizationManager
    @EnvironmentObject var userManager: UserManager

    @State private var showProfile = false
    @State private var sortOption: TopicSortOption = .alphabetical

    private var sortedTopics: [Topic] {
        switch sortOption {
        case .alphabetical:
            return viewModel.topics.sorted { $0.name < $1.name }
        case .progress:
            return viewModel.topics.sorted {
                let p1 = userManager.getUnlockedLevel(for: $0.name)
                let p2 = userManager.getUnlockedLevel(for: $1.name)
                return p1 > p2
            }
        }
    }

    var body: some View {
        List(sortedTopics) { topic in
            NavigationLink(destination: LevelSelectionView(topic: topic)) {
                VStack(alignment: .leading) {
                    Text(topic.name)
                        .font(.headline)

                    let level = userManager.getUnlockedLevel(for: topic.name)
                    let format = localization.localized("LevelProgress")
                    let levelText = String(format: format, "\(level)")

                    Text(levelText)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
        .navigationTitle(localization.localized("Home"))
        
        .navigationDestination(isPresented: $showProfile) {
            ProfileView()
        }
        .onChange(of: localization.currentLanguage) { newLang in
            viewModel.language = newLang
        }
    }
}
