//
//  MainTabView.swift
//  LearnEnglishApp
//
//  Created by Тимур Нуртдинов on 07.05.2025.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var localization: LocalizationManager
    @EnvironmentObject var userManager: UserManager

    @State private var selectedTab = 0
    @State private var showProfile = false

    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                HomeView()
                    .navigationTitle(localization.localized("Home"))
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Menu {
                                ForEach(AppLanguage.allCases) { lang in
                                    Button(action: {
                                        localization.currentLanguage = lang
                                    }) {
                                        if localization.currentLanguage == lang {
                                            Label(lang.rawValue, systemImage: "checkmark")
                                        } else {
                                            Text(lang.rawValue)
                                        }
                                    }
                                }
                            } label: {
                                Image(systemName: "globe")
                                    .font(.title2)
                            }
                        }

                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                showProfile = true
                            } label: {
                                Image(systemName: "person.circle")
                                    .font(.title2)
                            }
                        }
                    }
                    .navigationDestination(isPresented: $showProfile) {
                        ProfileView()
                    }
            }
            .tabItem {
                Label(localization.localized("Home"), systemImage: "house")
            }
            .tag(0)

            NavigationStack {
                SelectedView()
                    .navigationTitle(localization.localized("Favorites"))
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Menu {
                                ForEach(AppLanguage.allCases) { lang in
                                    Button(action: {
                                        localization.currentLanguage = lang
                                    }) {
                                        if localization.currentLanguage == lang {
                                            Label(lang.rawValue, systemImage: "checkmark")
                                        } else {
                                            Text(lang.rawValue)
                                        }
                                    }
                                }
                            } label: {
                                Image(systemName: "globe")
                                    .font(.title2)
                            }
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                showProfile = true
                            } label: {
                                Image(systemName: "person.circle")
                                    .font(.title2)
                            }
                        }
                    }
                    .navigationDestination(isPresented: $showProfile) {
                        ProfileView()
                    }
            }
            .tabItem {
                Label(localization.localized("Favorites"), systemImage: "star.fill")
            }
            .tag(1)

            NavigationStack {
                ProgressView()
                    .navigationTitle(localization.localized("Progress"))
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Menu {
                                ForEach(AppLanguage.allCases) { lang in
                                    Button(action: {
                                        localization.currentLanguage = lang
                                    }) {
                                        if localization.currentLanguage == lang {
                                            Label(lang.rawValue, systemImage: "checkmark")
                                        } else {
                                            Text(lang.rawValue)
                                        }
                                    }
                                }
                            } label: {
                                Image(systemName: "globe")
                                    .font(.title2)
                            }
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                showProfile = true
                            } label: {
                                Image(systemName: "person.circle")
                                    .font(.title2)
                            }
                        }
                    }
                    .navigationDestination(isPresented: $showProfile) {
                        ProfileView()
                    }
            }
            .tabItem {
                Label(localization.localized("Progress"), systemImage: "chart.bar.fill")
            }
            .tag(2)
        }
    }
}
