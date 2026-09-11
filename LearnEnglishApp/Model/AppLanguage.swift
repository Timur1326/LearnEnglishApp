//
//  AppLanguage.swift
//  LearnEnglishApp
//
//  Created by Тимур Нуртдинов on 07.05.2025.
//


import Foundation

enum AppLanguage: String, CaseIterable, Identifiable {
    case russian = "Русский"
    case czech = "Česky"
    
    var id: String { rawValue }

    var fileName: String {
        switch self {
        case .russian: return "phrases_ru"
        case .czech: return "phrases_cz"
        }
    }

    var uiFileSuffix: String {
        switch self {
        
        case .russian: return "ru"
        case .czech: return "cz"
        }
    }
}
