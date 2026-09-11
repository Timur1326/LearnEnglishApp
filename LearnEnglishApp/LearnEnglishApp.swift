//
//  learn_appApp.swift
//  LearnEnglishApp
//
//  Created by Тимур Нуртдинов on 07.05.2025.
//

import SwiftUI

@main
struct LearnEnglishApp: App {
    @StateObject var userManager = UserManager()
    @StateObject var localization = LocalizationManager()
    @StateObject var viewModel = TopicViewModel()

    var body: some Scene {
        WindowGroup {
            if userManager.currentUser != nil {
                MainTabView()
                    .environmentObject(userManager)
                    .environmentObject(localization)
                    .environmentObject(viewModel)
                    .onAppear {
                        viewModel.language = localization.currentLanguage 
                    }
            } else {
                AuthView()
                    .environmentObject(userManager)
                    .environmentObject(localization)
                    .environmentObject(viewModel)
                    .onAppear {
                        viewModel.language = localization.currentLanguage
                    }
            }
        }
    }
}
