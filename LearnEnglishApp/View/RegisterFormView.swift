//
//  RegisterFormView.swift
//  LearnEnglishApp
//
//  Created by Тимур Нуртдинов on 07.05.2025.
//

import SwiftUI

struct RegisterFormView: View {
    @EnvironmentObject var userManager: UserManager
    @EnvironmentObject var localization: LocalizationManager

    @Binding var showRegister: Bool
    @State private var name = ""
    @State private var login = ""
    @State private var password = ""
    @State private var error = ""

    var body: some View {
        VStack(spacing: 16) {
            TextField(localization.localized("Login"), text: $login)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            SecureField(localization.localized("Password"), text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            if !error.isEmpty {
                Text(localization.localized(error))
                    .foregroundColor(.red)
            }

            Button(localization.localized("Register")) {
                if !userManager.register(login: login, password: password) {
                    error = "LoginTaken"
                }
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(12)

            Button(localization.localized("AlreadyHaveAccount")) {
                showRegister = false
            }
            .padding(.top)
        }
        .padding()
    }
}
