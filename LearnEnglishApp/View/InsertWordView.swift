//
//  InsertWordView.swift
//  LearnEnglishApp
//
//  Created by Тимур Нуртдинов on 07.05.2025.
//


import SwiftUI

struct InsertWordView: View {
    let phrases: [Phrase]
    var onFinish: (() -> Void)? = nil

    @State private var currentIndex = 0
    @State private var isCorrect = false
    @State private var selected: String?
    @State private var showAnswer = false

    @EnvironmentObject var localization: LocalizationManager

    var body: some View {
        let phrase = phrases[currentIndex]
        let correctWord = getHiddenWord(from: phrase.text)
        let masked = phrase.text.replacingOccurrences(of: correctWord, with: "____")
        let options = generateOptions(correct: correctWord)

        let phraseIndexFormat = localization.localized("PhraseIndex")
        let phraseIndexText = String(format: phraseIndexFormat, "\(currentIndex + 1)", "\(phrases.count)")

        VStack(spacing: 24) {
            Text(phraseIndexText)
                .font(.subheadline)
                .foregroundColor(.secondary)

            Text(masked)
                .font(.title2)
                .multilineTextAlignment(.center)
                .padding()

            VStack(spacing: 12) {
                ForEach(options, id: \.self) { option in
                    Button(action: {
                        selected = option
                        showAnswer = true
                        isCorrect = option == correctWord
                    }) {
                        Text(option)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(selected == option
                                        ? (isCorrect ? Color.green : Color.red)
                                        : Color(.systemGray6))
                            .foregroundColor(.black)
                            .cornerRadius(10)
                            .shadow(radius: 1)
                    }
                    .disabled(showAnswer)
                }
            }

            if showAnswer {
                Text(isCorrect
                     ? localization.localized("CorrectAnswer")
                     : String(format: localization.localized("IncorrectAnswer"), correctWord)
                )
                .font(.headline)
                .padding()

                Button(localization.localized("NextButton")) {
                    if currentIndex < phrases.count - 1 {
                        currentIndex += 1
                    } else {
                        onFinish?()
                        currentIndex = 0
                    }
                    selected = nil
                    showAnswer = false
                    isCorrect = false
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(12)
            }

            Spacer()
        }
        .padding()
        .navigationTitle(localization.localized("InsertTitle"))
        .navigationBarTitleDisplayMode(.inline)
    }

    func getHiddenWord(from phrase: String) -> String {
        let words = phrase.components(separatedBy: " ")
        return words.last?.trimmingCharacters(in: .punctuationCharacters) ?? "you"
    }

    func generateOptions(correct: String) -> [String] {
        var options = ["you", "me", "see", "go", "look", "life", "know", "day", "time", "there"]
        options.removeAll { $0 == correct }
        options.shuffle()
        let final = Array(options.prefix(3)) + [correct]
        return final.shuffled()
    }
}
