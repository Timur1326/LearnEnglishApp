//
//  StringLocal.swift
//  learn_app
//
//  Created by Тимур Нуртдинов on 24.05.2025.
//

import Foundation

extension String {
    func localized(using manager: LocalizationManager) -> String {
        manager.localized(self)
    }

    func localized(using manager: LocalizationManager, _ args: CVarArg...) -> String {
        let format = manager.localized(self)

        if !format.contains("%") || args.isEmpty {
            return format
        }

        return String(format: format, locale: Locale.current, arguments: args)
    }
}
