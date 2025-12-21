//
//  RegistrationView.swift
//  CoffeeOk
//
//  Created by Iakim Boiunets on 18/12/2025.
//

import SwiftUI

struct RegistrationView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @Binding var showRegistration: Bool
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showPassword = false
    @State private var showConfirmPassword = false
    @State private var isAgreed = false
    
    init(showRegistration: Binding<Bool> = .constant(false)) {
        _showRegistration = showRegistration
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.black.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    // Заголовок
                    VStack(spacing: 12) {
                        Text("Регистрация")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.white)
                        
                        Text("Создайте аккаунт, чтобы начать")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                    }
                    .padding(.top, 40)
                    
                    // Поля ввода
                    VStack(spacing: 16) {
                        // Имя
                        CustomTextField(
                            placeholder: "Имя",
                            text: $name,
                            icon: "person.fill"
                        )
                        
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
                        
                        // Подтверждение пароля
                        CustomSecureField(
                            placeholder: "Подтвердите пароль",
                            text: $confirmPassword,
                            icon: "lock.fill",
                            showPassword: $showConfirmPassword
                        )
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 32)
                    
                    // Согласие с условиями
                    HStack(spacing: 12) {
                        Button(action: {
                            isAgreed.toggle()
                        }) {
                            Image(systemName: isAgreed ? "checkmark.square.fill" : "square")
                                .font(.system(size: 20))
                                .foregroundColor(isAgreed ? .purple : .gray)
                        }
                        
                        Text("Я согласен с условиями использования")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 24)
                    
                    // Кнопка регистрации
                    Button(action: {
                        register()
                    }) {
                        Text("Зарегистрироваться")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(isFormValid ? Color.purple : Color.gray.opacity(0.5))
                            .cornerRadius(12)
                    }
                    .disabled(!isFormValid)
                    .padding(.horizontal, 24)
                    .padding(.top, 8)
                    
                    // Кнопка входа
                    HStack(spacing: 4) {
                        Text("Уже есть аккаунт?")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                        
                        Button(action: {
                            showRegistration = false
                        }) {
                            Text("Войти")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.purple)
                        }
                    }
                    .padding(.top, 8)
                    .padding(.bottom, 40)
                }
            }
            .padding(.top, 60)
            
            // Кнопка назад
            Button(action: {
                showRegistration = false
            }) {
                Circle()
                    .fill(Color.black.opacity(0.5))
                    .frame(width: 40, height: 40)
                    .overlay(
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .semibold))
                    )
            }
            .padding(.leading, 16)
            .padding(.top, 8)
        }
    }
    
    private var isFormValid: Bool {
        !name.isEmpty &&
        !email.isEmpty &&
        email.contains("@") &&
        !password.isEmpty &&
        password.count >= 6 &&
        password == confirmPassword &&
        isAgreed
    }
    
    private func register() {
        // Логика регистрации
        viewModel.authenticate()
    }
}

struct CustomTextField: View {
    let placeholder: String
    @Binding var text: String
    let icon: String
    var keyboardType: UIKeyboardType = .default
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.gray)
                .font(.system(size: 16))
                .frame(width: 20)
            
            TextField(placeholder, text: $text)
                .foregroundColor(.white)
                .font(.system(size: 16))
                .keyboardType(keyboardType)
                .autocapitalization(.none)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 16)
        .background(Color(hex: "#1a1a1a"))
        .cornerRadius(12)
    }
}

struct CustomSecureField: View {
    let placeholder: String
    @Binding var text: String
    let icon: String
    @Binding var showPassword: Bool
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.gray)
                .font(.system(size: 16))
                .frame(width: 20)
            
            if showPassword {
                TextField(placeholder, text: $text)
                    .foregroundColor(.white)
                    .font(.system(size: 16))
                    .autocapitalization(.none)
            } else {
                SecureField(placeholder, text: $text)
                    .foregroundColor(.white)
                    .font(.system(size: 16))
            }
            
            Button(action: {
                showPassword.toggle()
            }) {
                Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                    .foregroundColor(.gray)
                    .font(.system(size: 16))
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 16)
        .background(Color(hex: "#1a1a1a"))
        .cornerRadius(12)
    }
}

