//
//  ProfileView.swift
//  LearnEnglishApp
//
//  Created by Тимур Нуртдинов on 07.05.2025.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var localization: LocalizationManager
    @EnvironmentObject var viewModel: TopicViewModel
    @EnvironmentObject var userManager: UserManager

    @State private var selectedLanguage: AppLanguage = .russian
    var body: some View {
        VStack(spacing: 20) {
            if let user = userManager.currentUser {
//                Text("👤 \(user.name)")
//                    .font(.title)

                Text("\(localization.localized("Login")): \(user.login)")
                    .foregroundColor(.secondary)

                Button(localization.localized("Logout")) {
                    userManager.logout()
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(12)
                .padding(.top)

                Divider()

                Text(localization.localized("Language"))
                    .font(.headline)

                Picker(localization.localized("Language"), selection: $selectedLanguage) {
                    ForEach(AppLanguage.allCases) { lang in
                        Text(lang.rawValue).tag(lang)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .padding(.horizontal)
            } else {
                Text(localization.localized("ErrorUserNotFound"))
            }

            Spacer()
        }
        .padding()
        .navigationTitle(localization.localized("Profile"))
        .onAppear {
            selectedLanguage = localization.currentLanguage
        }
        .onChange(of: selectedLanguage) { newLang in
            if localization.currentLanguage != newLang {
                localization.currentLanguage = newLang
//                viewModel.language = newLang
                viewModel.loadTopics(for: localization.currentLanguage)
            }
        }
    }
}
