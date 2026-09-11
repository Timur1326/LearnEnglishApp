//
//  LevelSelectionView.swift
//  LearnEnglishApp
//
//  Created by Тимур Нуртдинов on 07.05.2025.
//


import SwiftUI

struct LevelSelectionView: View {
    let topic: Topic

    @EnvironmentObject var userManager: UserManager
    @EnvironmentObject var localization: LocalizationManager

    @State private var showLockedAlert = false
    @State private var lockedMessage = ""

    var body: some View {
        ZStack {
            List {
                NavigationLink(destination:
                    CardLevelView(phrases: topic.phrases, onFinish: {
                        userManager.unlockNextLevel(for: topic.name, completed: 1)
                    })
                ) {
                    Label("Level1".localized(using: localization), systemImage: "rectangle.on.rectangle")
                }

                if userManager.isLevelUnlocked(topic: topic.name, level: 2) {
                    NavigationLink(destination:
                        InsertWordView(phrases: topic.phrases, onFinish: {
                            userManager.unlockNextLevel(for: topic.name, completed: 2)
                        })
                    ) {
                        Label("Level2".localized(using: localization), systemImage: "square.and.pencil")
                    }
                } else {
                    Button(action: {
                        showMessage(localization.localized("CompletePreviousLevel"))
                    }) {
                        Label("Level2Locked".localized(using: localization), systemImage: "lock")
                            .foregroundColor(.gray)
                    }
                }

                if userManager.isLevelUnlocked(topic: topic.name, level: 3) {
                    NavigationLink(destination: SentenceBuilderView(phrases: topic.phrases)) {
                        Label("Level3".localized(using: localization), systemImage: "text.badge.plus")
                    }
                } else {
                    Button(action: {
                        showMessage(localization.localized("CompletePreviousLevel"))
                    }) {
                        Label("Level3Locked".localized(using: localization), systemImage: "lock")
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle(topic.name)

            .overlay(alignment: .bottom) {
                if showLockedAlert {
                    VStack {
                        Spacer()
                        Text(lockedMessage)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.red.opacity(0.95))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .padding(.horizontal)
                            .padding(.bottom, 20)
                            .shadow(radius: 10)
                            .transition(.move(edge: .bottom).combined(with: .opacity))
                            .zIndex(1)
                    }
                    .animation(.easeInOut(duration: 0.3), value: showLockedAlert)
                }
            }
        }
    }

    private func showMessage(_ text: String) {
        lockedMessage = text
        withAnimation {
            showLockedAlert = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation {
                showLockedAlert = false
            }
        }
    }
}
