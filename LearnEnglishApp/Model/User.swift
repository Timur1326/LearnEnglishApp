//
//  User.swift
//  LearnEnglishApp
//
//  Created by Тимур Нуртдинов on 07.05.2025.
//


import Foundation

struct User: Codable, Identifiable {
    var id = UUID()
    let login: String
    let password: String
    var progress: [String: Int]
    
    var favorites: Set<String> = []
    
    var learnedHistory: [String: Date] = [:] 
}
