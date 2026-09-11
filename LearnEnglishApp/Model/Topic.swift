//
//  Topic.swift
//  LearnEnglishApp
//
//  Created by Тимур Нуртдинов on 07.05.2025.
//


import Foundation

struct Topic: Identifiable {
    let id = UUID()
    let name: String
    let phrases: [Phrase]
}
