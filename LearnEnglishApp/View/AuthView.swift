//
//  AuthView.swift
//  LearnEnglishApp
//
//  Created by Тимур Нуртдинов on 07.05.2025.
//



import SwiftUI

struct AuthView: View {
    @EnvironmentObject var userManager: UserManager
    @State private var showRegister = false

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                if showRegister {
                    RegisterFormView(showRegister: $showRegister)
                } else {
                    LoginFormView(showRegister: $showRegister)
                }
            }
            .padding()
            .navigationTitle(showRegister ? "Log in" : "Sign in")
            
        }
    }
}
