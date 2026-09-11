//
//  WrapView.swift
//  LearnEnglishApp
//
//  Created by Тимур Нуртдинов on 07.05.2025.
//

import SwiftUI

enum WordStyle {
    case option, selected
}

struct WrapView: View {
    let items: [String]
    let style: WordStyle
    let onTap: (String) -> Void

    var body: some View {
        VStack {
            FlowLayout(items: items, spacing: 8) { word in
                Text(word)
                    .padding(.vertical, 6)
                    .padding(.horizontal, 12)
                    .background(style == .selected ? Color.green.opacity(0.2) : Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .onTapGesture { onTap(word) }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
