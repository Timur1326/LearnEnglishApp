# LearnEnglishApp

An iOS app built with SwiftUI for learning English phrases through flashcards, fill-in-the-blank quizzes, and sentence-building exercises. The UI is available in Russian and Czech.

## Features

- **Sign up / log in** with a login and password (stored locally via `UserDefaults`)
- **Topics** — phrases are grouped by topic, each with its own progress
- **Three learning levels** per topic, unlocked sequentially:
  1. **Flashcards** — swipe through cards with translation and usage example, mark phrases as favorites
  2. **Fill in the word** — multiple-choice quiz on the missing word in a phrase
  3. **Build the sentence** — assemble a phrase from shuffled words
- **Favorites** — saved phrases available in a separate tab
- **Progress** — stats on learned phrases for today / this week / this month / all time
- **Profile** — log out, switch the interface language
- **Localization** — switch the app language (Russian / Czech) on the fly

## Architecture

The project follows the **MVVM** pattern:

```
LearnEnglishApp/
├── Model/            # Phrase, Topic, User, AppLanguage, PhraseContent
├── ViewModel/         # UserManager, TopicViewModel, LocalizationManager
├── View/              # SwiftUI screens and reusable components
└── Resources/         # JSON files with phrases and UI strings (ru/cz)
```

- **`UserManager`** — sign up/login, per-topic progress, favorites, learned-phrase history
- **`TopicViewModel`** — loads phrases from `Resources/phrases_{ru,cz}.json`
- **`LocalizationManager`** — loads UI strings from `Resources/ui_strings_{ru,cz}.json`

## Requirements

- Xcode 15+
- iOS 17+ (SwiftUI)

## Getting started

1. Open `LearnEnglishApp.xcodeproj` in Xcode
2. Select an iPhone simulator
3. Run (⌘R)

## Tests

The project includes `LearnEnglishAppTests` and `LearnEnglishAppUITests` targets (basic Xcode-generated scaffolding).
