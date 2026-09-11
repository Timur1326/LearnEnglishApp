//
//  SelectedView.swift
//  LearnEnglishApp
//
//  Created by Тимур Нуртдинов on 07.05.2025.
//

import SwiftUI

struct SelectedView: View {
    @EnvironmentObject var userManager: UserManager
    @EnvironmentObject var localization: LocalizationManager
    @EnvironmentObject var viewModel: TopicViewModel

    var body: some View {
        List {
            let favorites = userManager.getFavoritePhrases(from: viewModel.topics)

            ForEach(favorites, id: \.self) { phrase in
                VStack(alignment: .leading, spacing: 8) {
                    Text(phrase.text)
                        .font(.headline)
                    Text(phrase.translation)
                        .foregroundColor(.gray)
                    Text(phrase.example)
                        .italic()
                        .font(.caption)
                }
                .padding(.vertical, 4)
            }
            .onDelete { indexSet in
                let favorites = userManager.getFavoritePhrases(from: viewModel.topics)
                for index in indexSet {
                    let phrase = favorites[index]
                    userManager.toggleFavorite(phrase)
                }
            }
        }
        .listStyle(.plain) 
        .navigationTitle(localization.localized("Favorites"))
        .navigationBarTitleDisplayMode(.large)
    }
}
