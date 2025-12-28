//
//  RoleSelectionView.swift
//  CoffeeOk
//
//  Created by Iakim Boiunets on 22/12/2025.
//

import SwiftUI

struct RoleSelectionView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State private var selectedRole: UserRole = .coffeeLover

    var body: some View {
        ZStack {
            Color(hex: "#0e0e11").ignoresSafeArea()

            VStack(spacing: 0) {
                // Заголовок
                Text("Кто вы в CoffeeOk?")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.top, 40)
                    .padding(.bottom, 80)

                // Карточки выбора роли
                HStack(spacing: 16) {
                    // Карточка "Кофеман"
                    RoleCard(
                        title: "☕ Кофеман",
                        description: "Открываю новые вкусы и места",
                        isSelected: selectedRole == .coffeeLover,
                        action: {
                            selectedRole = .coffeeLover
                        }
                    )

                    // Карточка "Кофешоп"
                    RoleCard(
                        title: "🏪 Кофешоп",
                        description: "Я представляю кофейню",
                        isSelected: selectedRole == .coffeeShop,
                        action: {
                            selectedRole = .coffeeShop
                        }
                    )
                }
                .padding(.horizontal, 32)

                Spacer()

                // Кнопка "Продолжить"
                Button(action: {
                    viewModel.selectedRole = selectedRole
                    viewModel.showRoleSelection = false
                    if selectedRole == .coffeeShop {
                        viewModel.showCoffeeShopRegistration = true
                    } else {
                        viewModel.showRegistration = true
                    }
                }) {
                    Text("Продолжить")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color(hex: "#8b2d6b"))
                        .cornerRadius(28)
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 50)
            }
        }
    }
}

struct RoleCard: View {
    let title: String
    let description: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 20) {
                // Иконка
                ZStack {
                    Circle()
                        .fill(Color(hex: "#374151"))
                        .frame(width: 60, height: 60)

                    Text(String(title.prefix(1)))
                        .font(.system(size: 30))
                }

                // Заголовок
                Text(title)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)

                // Описание
                Text(description)
                    .font(.system(size: 16))
                    .foregroundColor(Color(hex: "#9ca3af"))
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .padding(.horizontal, 16)
            .background(Color(hex: "#1f2937"))
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(isSelected ? Color(hex: "#8b2d6b") : Color.clear, lineWidth: 2)
            )
            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
