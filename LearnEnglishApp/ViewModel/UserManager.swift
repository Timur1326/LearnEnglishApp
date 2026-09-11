//
//  UserManager.swift
//  learn_app
//
//  Created by Тимур Нуртдинов on 07.05.2025.
//


import Foundation

class UserManager: ObservableObject {
    @Published var currentUser: User?
    @Published var allUsers: [User] = []

    private let usersKey = "stored_users"
    private let currentUserKey = "logged_user_login"

    init() {
        loadUsers()
        autoLoginIfPossible()
    }

    func register(login: String, password: String) -> Bool {
        guard !allUsers.contains(where: { $0.login == login }) else {
            return false // логин уже занят
        }

        let newUser = User(login: login, password: password, progress: [:], favorites: [])
        allUsers.append(newUser)
        saveUsers()
        loginUser(login: login, password: password)
        return true
    }

    func loginUser(login: String, password: String) -> Bool {
        guard let user = allUsers.first(where: { $0.login == login && $0.password == password }) else {
            return false
        }
        currentUser = user
        saveCurrentUserLogin(login)
        return true
    }

    func logout() {
        currentUser = nil
        UserDefaults.standard.removeObject(forKey: currentUserKey)
    }

    func updateProgress(topic: String, level: Int) {
        guard var user = currentUser else { return }

        let current = user.progress[topic] ?? 1
        if level >= current && level < 3 {
            user.progress[topic] = level + 1
        }

        if let index = allUsers.firstIndex(where: { $0.login == user.login }) {
            allUsers[index] = user
            currentUser = user
            saveUsers()
        }
    }

    func getUnlockedLevel(for topic: String) -> Int {
        currentUser?.progress[topic] ?? 1
    }

    private func loadUsers() {
        if let data = UserDefaults.standard.data(forKey: usersKey),
           let decoded = try? JSONDecoder().decode([User].self, from: data) {
            allUsers = decoded
        }
    }

    private func saveUsers() {
        if let data = try? JSONEncoder().encode(allUsers) {
            UserDefaults.standard.set(data, forKey: usersKey)
        }
    }

    private func saveCurrentUserLogin(_ login: String) {
        UserDefaults.standard.set(login, forKey: currentUserKey)
    }

    private func autoLoginIfPossible() {
        let login = UserDefaults.standard.string(forKey: currentUserKey)
        if let user = allUsers.first(where: { $0.login == login }) {
            currentUser = user
        }
    }
    
    
    func isLevelUnlocked(topic: String, level: Int) -> Bool {
        (currentUser?.progress[topic] ?? 1) >= level
    }

    func unlockNextLevel(for topic: String, completed level: Int) {
        guard var user = currentUser else { return }

        let current = user.progress[topic] ?? 1
        if level >= current && level < 3 {
            user.progress[topic] = level + 1
        }

      
        if let index = allUsers.firstIndex(where: { $0.login == user.login }) {
            allUsers[index] = user
            currentUser = user
            saveUsers()
        }
    }
    
    func isFavorite(_ phrase: Phrase) -> Bool {
        currentUser?.favorites.contains(phrase.text) ?? false
    }

    func toggleFavorite(_ phrase: Phrase) {
        guard let user = currentUser else { return }

        var updatedFavorites = user.favorites

        if updatedFavorites.contains(phrase.text) {
            updatedFavorites.remove(phrase.text)
        } else {
            updatedFavorites.insert(phrase.text)
        }

        let updatedUser = User(
            id: user.id,
            login: user.login,
            password: user.password,
            progress: user.progress,
            favorites: updatedFavorites,
            learnedHistory: user.learnedHistory 
        )

        if let index = allUsers.firstIndex(where: { $0.login == user.login }) {
            allUsers[index] = updatedUser
            objectWillChange.send()
            currentUser = updatedUser
            saveUsers()
        }
    }

    func getFavoritePhrases(from topics: [Topic]) -> [Phrase] {
        let allPhrases = topics.flatMap { $0.phrases }
        let fav = currentUser?.favorites ?? []
        return allPhrases.filter { fav.contains($0.text) }
    }
    
    
    func markPhraseAsLearned(_ phrase: Phrase) {
        guard let user = currentUser else { return }

        var updatedHistory = user.learnedHistory
        updatedHistory[phrase.text] = Date()

        let updatedUser = User(
            id: user.id,
            login: user.login,
            password: user.password,
            progress: user.progress,
            favorites: user.favorites,
            learnedHistory: updatedHistory
        )

        if let index = allUsers.firstIndex(where: { $0.login == user.login }) {
            allUsers[index] = updatedUser
            objectWillChange.send()
            currentUser = updatedUser
            saveUsers()
        }
    }
}



