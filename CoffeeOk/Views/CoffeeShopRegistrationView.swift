//
//  CoffeeShopRegistrationView.swift
//  CoffeeOk
//
//  Created by Iakim Boiunets on 22/12/2025.
//

import SwiftUI

struct CoffeeShopRegistrationView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State private var shopName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var address = ""
    @State private var phone = ""
    @State private var description = ""
    @State private var cuisineType = ""
    @State private var showPassword = false
    @State private var showConfirmPassword = false
    @State private var isAgreed = false
    @State private var showValidationDebug = false

    var body: some View {
        ZStack(alignment: .topLeading) {
            Color(hex: "#0e0e11").ignoresSafeArea()

            ScrollView {
                VStack(spacing: 24) {
                    // Заголовок
                    VStack(spacing: 12) {
                        Text("Регистрация кофейни")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.white)

                        Text("Заполните информацию о вашей кофейне")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)

                        Text("* - обязательные поля")
                            .font(.system(size: 12))
                            .foregroundColor(.gray.opacity(0.7))
                    }
                    .padding(.top, 40)

                    // Поля ввода
                    VStack(spacing: 16) {
                        // Название кофейни
                        CustomTextField(
                            placeholder: "Название кофейни *",
                            text: $shopName,
                            icon: "building.2.fill"
                        )

                        // Email
                        CustomTextField(
                            placeholder: "Email *",
                            text: $email,
                            icon: "envelope.fill",
                            keyboardType: .emailAddress
                        )

                        // Телефон
                        CustomTextField(
                            placeholder: "Телефон *",
                            text: $phone,
                            icon: "phone.fill",
                            keyboardType: .phonePad
                        )

                        // Адрес
                        CustomTextField(
                            placeholder: "Адрес кофейни *",
                            text: $address,
                            icon: "location.fill"
                        )

                        // Тип кухни
                        CustomTextField(
                            placeholder: "Тип кухни (например: итальянская, азиатская)",
                            text: $cuisineType,
                            icon: "fork.knife"
                        )

                        // Пароль
                        CustomSecureField(
                            placeholder: "Пароль *",
                            text: $password,
                            icon: "lock.fill",
                            showPassword: $showPassword
                        )

                        // Подтверждение пароля
                        CustomSecureField(
                            placeholder: "Подтвердите пароль *",
                            text: $confirmPassword,
                            icon: "lock.fill",
                            showPassword: $showConfirmPassword
                        )

                        // Описание кофейни
                        ZStack(alignment: .topLeading) {
                            if description.isEmpty {
                                Text("Расскажите о вашей кофейне...")
                                    .foregroundColor(.gray.opacity(0.7))
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 16)
                                    .font(.system(size: 16))
                            }

                            TextEditor(text: $description)
                                .foregroundColor(.white)
                                .font(.system(size: 16))
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .frame(height: 100)
                                .background(Color(hex: "#1a1a1a"))
                                .cornerRadius(12)
                                .scrollContentBackground(.hidden)
                        }
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
                                .foregroundColor(isAgreed ? Color(hex: "#8b2d6b") : .gray)
                        }

                        Text("Я согласен с условиями использования *")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)

                        Spacer()
                    }
                    .padding(.horizontal, 24)

                    // Кнопка регистрации
                    Button(action: {
                        registerCoffeeShop()
                    }) {
                        Text("Зарегистрировать кофейню")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(isFormValid ? Color(hex: "#8b2d6b") : Color.gray.opacity(0.5))
                            .cornerRadius(12)
                    }
                    .disabled(!isFormValid)
                    .padding(.horizontal, 24)
                    .padding(.top, 8)

                    // Отладочная информация (временно)
                    if showValidationDebug {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Статус валидации:").font(.caption).foregroundColor(.gray)
                            Group {
                                Text("Название: \(!shopName.isEmpty ? "✓" : "✗")").font(.caption)
                                Text("Email: \(!email.isEmpty && email.contains("@") ? "✓" : "✗")").font(.caption)
                                Text("Пароль: \(!password.isEmpty && password.count >= 6 ? "✓" : "✗")").font(.caption)
                                Text("Подтверждение: \(password == confirmPassword ? "✓" : "✗")").font(.caption)
                                Text("Адрес: \(!address.isEmpty ? "✓" : "✗")").font(.caption)
                                Text("Телефон: \(!phone.isEmpty ? "✓" : "✗")").font(.caption)
                                Text("Согласие: \(isAgreed ? "✓" : "✗")").font(.caption)
                            }
                            .foregroundColor(.white)
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 8)
                    }

                    // Кнопка отладки
                    Button(action: {
                        showValidationDebug.toggle()
                    }) {
                        Text(showValidationDebug ? "Скрыть статус" : "Показать статус валидации")
                            .font(.system(size: 12))
                            .foregroundColor(.purple)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 4)

                    // Кнопка назад к выбору роли
                    HStack(spacing: 4) {
                        Text("Вернуться к выбору роли")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)

                        Spacer()
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 8)
                    .padding(.bottom, 40)
                }
            }
            .padding(.top, 60)

            // Кнопка назад
            Button(action: {
                viewModel.showCoffeeShopRegistration = false
                viewModel.showRoleSelection = true
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
        // Временно отключена валидация для тестирования
        true
    }

    private func registerCoffeeShop() {
        // Логика регистрации кофейни
        viewModel.showCoffeeShopRegistration = false
        viewModel.isAuthenticated = true
    }
}
