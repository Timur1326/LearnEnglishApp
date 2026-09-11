//
//  TopicViewModel.swift
//  learn_app
//
//  Created by Тимур Нуртдинов on 07.05.2025.
//



import Foundation

class TopicViewModel: ObservableObject {
    @Published var topics: [Topic] = []
    @Published var language: AppLanguage = .czech { 
        didSet {
            loadTopics(for: language)
        }
    }

    init(language: AppLanguage = .czech) {
        self.language = language
        loadTopics(for: language)
    }

    func loadTopics(for language: AppLanguage) {
        guard let url = Bundle.main.url(forResource: language.fileName, withExtension: "json") else {
            return
        }

        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode([String: [String: PhraseContent]].self, from: data)

            self.topics = decoded.map { topicName, phraseDict in
                let phrases = phraseDict.map { key, value in
                    Phrase(text: key, translation: value.translation, example: value.example)
                }
                return Topic(name: topicName, phrases: phrases)
            }.sorted { $0.name < $1.name }
        } catch {
            print("Error in JSON: \(error)")
        }
    }
}
