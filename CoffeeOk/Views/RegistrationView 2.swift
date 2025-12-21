//
//  RegistrationView.swift
//  CoffeeOk
//
//  Created by Assistant on 19/12/2025.
//

import SwiftUI

struct RegistrationView: View {
    @Binding var showRegistration: Bool
    @EnvironmentObject var viewModel: AppViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showPassword = false
    @State private var showConfirmPassword = false
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(spacing: 24) {
                Spacer()
                
                Text("Регистрация")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.white)
                
                Spacer()
                
                VStack(spacing: 16) {
                    // Email
                    CustomTextField(
                        placeholder: "Email",
                        text: $email,
                        icon: "envelope.fill",
                        keyboardType: UIKeyboardType.emailAddress
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
                        placeholder: "Повторите пароль",
                        text: $confirmPassword,
                        icon: "lock.rotation",
                        showPassword: $showConfirmPassword
                    )
                }
                .padding(.horizontal, 32)
                
                Button(action: {
                    // Тут можно добавить регистрацию пользователя
                    viewModel.authenticate()
                    showRegistration = false
                }) {
                    Text("Зарегистрироваться")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color.purple)
                        .cornerRadius(12)
                }
                .padding(.horizontal, 32)
                
                Button(action: {
                    showRegistration = false
                }) {
                    Text("Уже есть аккаунт? Войти")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.purple)
                        .padding(.top, 8)
                }
                Spacer(minLength: 60)
            }
        }
    }
}

// MARK: - Custom Text Field Components

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
        .background(Color(hex: "1a1a1a"))
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
        .background(Color(hex: "1a1a1a"))
        .cornerRadius(12)
    }
}
