//
//  SentenceBuilderView.swift
//  LearnEnglishApp
//
//  Created by Тимур Нуртдинов on 07.05.2025.
//



import SwiftUI

struct SentenceBuilderView: View {
    let phrases: [Phrase]

    @EnvironmentObject var localization: LocalizationManager

    @State private var currentIndex = 0
    @State private var selectedWords: [String] = []
    @State private var shuffledWords: [String] = []
    @State private var showResult = false
    @State private var isCorrect = false

    var body: some View {
        let phrase = phrases[currentIndex]
        let originalWords = phrase.text
            .components(separatedBy: .whitespaces)
            .map { $0.trimmingCharacters(in: .punctuationCharacters) }

        VStack(spacing: 20) {
            Text("\(localization.localized("Sentence")) \(currentIndex + 1) \(localization.localized("of")) \(phrases.count)")
                .font(.subheadline)
                .foregroundColor(.secondary)

            Text(localization.localized("BuildPhrase"))
                .font(.headline)

            WrapView(items: selectedWords, style: .selected) { word in
                selectedWords.removeAll { $0 == word }
                showResult = false
            }

            Divider()

            WrapView(items: shuffledWords.filter { !selectedWords.contains($0) }, style: .option) { word in
                selectedWords.append(word)
                showResult = false
            }

            if showResult {
                Text(
                    isCorrect ?
                        localization.localized("CorrectAnswer") :
                        "\(localization.localized("WrongAnswer"))\n\n\(localization.localized("Original")):\n\"\(phrase.text)\""
                )
                .multilineTextAlignment(.center)
                .foregroundColor(isCorrect ? .green : .red)
                .padding()
            }

            Button(localization.localized("Check")) {
                let joined = selectedWords.joined(separator: " ").trimmingCharacters(in: .punctuationCharacters)
                let cleanOriginal = phrase.text.trimmingCharacters(in: .punctuationCharacters)
                isCorrect = joined.caseInsensitiveCompare(cleanOriginal) == .orderedSame
                showResult = true
            }
            .disabled(selectedWords.count != originalWords.count)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(12)

            if showResult {
                Button(localization.localized("Next")) {
                    currentIndex = (currentIndex + 1) % phrases.count
                    prepareNext()
                }
                .padding(.top, 8)
            }

            Spacer()
        }
        .padding()
        .navigationTitle(localization.localized("BuildPhrase"))
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: prepareNext)
    }

    private func prepareNext() {
        let words = phrases[currentIndex].text
            .components(separatedBy: .whitespaces)
            .map { $0.trimmingCharacters(in: .punctuationCharacters) }
        shuffledWords = words.shuffled()
        selectedWords = []
        showResult = false
        isCorrect = false
    }
}
