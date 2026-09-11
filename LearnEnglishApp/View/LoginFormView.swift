//
//  LoginFormView.swift
//  LearnEnglishApp
//
//  Created by Тимур Нуртдинов on 07.05.2025.
//


import SwiftUI

struct LoginFormView: View {
    @EnvironmentObject var userManager: UserManager
    @EnvironmentObject var localization: LocalizationManager

    @Binding var showRegister: Bool
    @State private var login = ""
    @State private var password = ""
    @State private var error = ""

    var body: some View {
        VStack {
            TextField(localization.localized("Login"), text: $login)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            SecureField(localization.localized("Password"), text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            if !error.isEmpty {
                Text(error)
                    .foregroundColor(.red)
            }

            Button(localization.localized("LoginButton")) {
                if !userManager.loginUser(login: login, password: password) {
                    error = localization.localized("LoginError")
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(12)

            Button(localization.localized("NoAccountRegister")) {
                showRegister = true
            }
            .padding(.top)
        }
    }
}
