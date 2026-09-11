//
//  Phrase.swift
//  LearnEnglishApp
//
//  Created by Тимур Нуртдинов on 07.05.2025.
//


import Foundation

struct Phrase: Identifiable, Hashable, Codable {
    let id = UUID()
    let text: String
    let translation: String
    let example: String
}
