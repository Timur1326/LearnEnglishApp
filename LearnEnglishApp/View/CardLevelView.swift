//
//  CardLevelView.swift
//  LearnEnglishApp
//
//  Created by Тимур Нуртдинов on 07.05.2025.
//

import SwiftUI

struct CardLevelView: View {
    let phrases: [Phrase]
    var onFinish: (() -> Void)? = nil

    @State private var currentIndex = 0
    @EnvironmentObject var userManager: UserManager
    @EnvironmentObject var localization: LocalizationManager
    @State private var showFavoriteMessage = false
    @State private var favoriteMessageText = ""
    @State private var favoriteIconScale: CGFloat = 1.0

    var body: some View {
        VStack {
            let indexTextFormat = localization.localized("CardIndex")
            let indexText = String(format: indexTextFormat, "\(currentIndex + 1)", "\(phrases.count)")

            Text(indexText)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.top)

            TabView(selection: $currentIndex) {
                ForEach(0..<phrases.count, id: \.self) { index in
                    let phrase = phrases[index]

                    VStack(spacing: 20) {
                        Spacer()

                        VStack(spacing: 16) {
                            HStack {
                                Spacer()
                                Button(action: {
                                    userManager.toggleFavorite(phrase)

                                    if userManager.isFavorite(phrase) {
                                        favoriteMessageText = localization.localized("FavoriteAdded")
                                    } else {
                                        favoriteMessageText = localization.localized("FavoriteRemoved")
                                    }

                                    withAnimation {
                                        showFavoriteMessage = true
                                        favoriteIconScale = 1.3
                                    }

                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.4)) {
                                        favoriteIconScale = 1.0
                                    }

                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                        withAnimation {
                                            showFavoriteMessage = false
                                        }
                                    }
                                }) {
                                    Image(systemName: userManager.isFavorite(phrase) ? "star.fill" : "star")
                                        .foregroundColor(.yellow)
                                        .font(.title2)
                                        .scaleEffect(favoriteIconScale)
                                }
                            }

                            Text(phrase.text)
                                .font(.largeTitle)
                                .multilineTextAlignment(.center)

                            Text(phrase.translation)
                                .font(.title2)
                                .foregroundColor(.gray)

                            Text(phrase.example)
                                .font(.body)
                                .italic()
                                .multilineTextAlignment(.center)
                                .padding(.top)
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(20)
                        .shadow(radius: 5)

                        Spacer()
                    }
                    .tag(index)
                    .padding(.horizontal, 20)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .onChange(of: currentIndex) { newIndex in
                let phrase = phrases[newIndex]
                userManager.markPhraseAsLearned(phrase)

                if newIndex == phrases.count - 1 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        onFinish?()
                    }
                }
            }
        }
        .navigationTitle(localization.localized("CardTitle"))
        .navigationBarTitleDisplayMode(.inline)
        .overlay(
            VStack {
                if showFavoriteMessage {
                    Text(favoriteMessageText)
                        .font(.footnote)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.black.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .transition(.move(edge: .top).combined(with: .opacity))
                        .padding(.top, 60)
                }
                Spacer()
            }
        )
    }
}
