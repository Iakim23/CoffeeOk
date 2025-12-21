//
//  AuthView.swift
//  CoffeeOk
//
//  Created by Iakim Boiunets on 18/12/2025.
//

import SwiftUI

struct AuthView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State private var showRegistration = false
    @State private var email = ""
    @State private var password = ""
    @State private var showPassword = false
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            if showRegistration {
                RegistrationView(showRegistration: $showRegistration)
                    .environmentObject(viewModel)
            } else {
                VStack(spacing: 24) {
                    Spacer()
                    
                    Text("CoffeeOk")
                        .font(.system(size: 48, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text("Добро пожаловать в пространство любителей кофе ☕")
                        .font(.system(size: 20))
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    // Поля ввода
                    VStack(spacing: 16) {
                        // Email
                        CustomTextField(
                            placeholder: "Email",
                            text: $email,
                            icon: "envelope.fill",
                            keyboardType: .emailAddress
                        )
                        
                        // Пароль
                        CustomSecureField(
                            placeholder: "Пароль",
                            text: $password,
                            icon: "lock.fill",
                            showPassword: $showPassword
                        )
                    }
                    .padding(.horizontal, 32)
                    
                    // Кнопка входа
                    Button(action: {
                        viewModel.authenticate()
                    }) {
                        Text("Войти")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color.purple)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal, 32)
                    
                    // Кнопка регистрации
                    HStack(spacing: 4) {
                        Text("Нет аккаунта?")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                        
                        Button(action: {
                            showRegistration = true
                        }) {
                            Text("Зарегистрироваться")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.purple)
                        }
                    }
                    .padding(.top, 8)
                    .padding(.bottom, 50)
                }
            }
        }
    }
}

