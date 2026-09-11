//
//  LocalizationManager.swift
//  learn_app
//
//  Created by Тимур Нуртдинов on 24.05.2025.
//

import Foundation
import SwiftUI

class LocalizationManager: ObservableObject {
    @Published var currentLanguage: AppLanguage = .czech {
        didSet {
            saveLanguage()
            loadStrings()
        }
    }

    private var strings: [String: String] = [:]
    private let languageKey = "selected_app_language"

    init() {
        if let savedRaw = UserDefaults.standard.string(forKey: languageKey),
           let savedLang = AppLanguage(rawValue: savedRaw) {
            self.currentLanguage = savedLang
        } else {
            self.currentLanguage = .czech  
        }

        loadStrings()
    }

    func localized(_ key: String) -> String {
        strings[key] ?? key
    }

    private func loadStrings() {
        let filename = "ui_strings_\(currentLanguage.uiFileSuffix)"
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let decoded = try? JSONDecoder().decode([String: String].self, from: data)
        else {
            print("Error in download \(filename).json")
            return
        }

        self.strings = decoded
    }

    private func saveLanguage() {
        UserDefaults.standard.set(currentLanguage.rawValue, forKey: languageKey)
    }
}
