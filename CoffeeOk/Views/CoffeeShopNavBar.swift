//
//  CoffeeShopNavBar.swift
//  CoffeeOk
//
//  Created by Iakim Boiunets on 22/12/2025.
//

import SwiftUI
import UIKit

enum CoffeeShopTab {
    case home
    case menu
    case reviews
    case analytics
    case profile
}

struct CoffeeShopNavBar: View {
    @EnvironmentObject var viewModel: AppViewModel
    @Binding var selectedTab: CoffeeShopTab

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                // Инсайты
                NavBarItem(
                    icon: "chart.bar",
                    title: "Инсайты",
                    isSelected: selectedTab == .analytics,
                    action: {
                        selectedTab = .analytics
                    }
                )

                // Витрина
                NavBarItem(
                    icon: "square.grid.2x2",
                    title: "Витрина",
                    isSelected: selectedTab == .home,
                    action: {
                        selectedTab = .home
                    }
                )

                // Люди
                NavBarItem(
                    icon: "person.2",
                    title: "Люди",
                    isSelected: selectedTab == .reviews,
                    action: {
                        selectedTab = .reviews
                    }
                )

                // Уведомления
                NavBarItem(
                    icon: "bell",
                    title: "Уведомления",
                    isSelected: selectedTab == .profile,
                    action: {
                        selectedTab = .profile
                    }
                )
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .frame(height: 72)
            .background(
                ZStack {
                    Color(hex: "#0B0B0B").opacity(0.85)
                    Color.white.opacity(0.1) // Для эффекта blur
                }
                .clipShape(RoundedRectangle(cornerRadius: 20))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.white.opacity(0.1), lineWidth: 0.5)
            )
            .shadow(
                color: Color(hex: "#000000").opacity(0.4),
                radius: 20,
                x: 0,
                y: 8
            )
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 12)
    }
}

struct NavBarItem: View {
    let icon: String
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: {
            // Haptic feedback
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()

            action()
        }) {
            VStack(spacing: 4) {
                Image(systemName: icon + (isSelected && icon == "square.grid.2x2" ? ".fill" : ""))
                    .font(.system(size: 22))
                    .foregroundColor(isSelected ? Color(hex: "#FFFFFF") : Color(hex: "#7A7A7A"))

                Text(title)
                    .font(.system(size: 11, weight: .medium))
                    .foregroundColor(isSelected ? Color(hex: "#FFFFFF") : Color(hex: "#7A7A7A"))
                    .lineSpacing(14 - 11) // lineHeight - fontSize
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
        }
        .buttonStyle(ScaleButtonStyle())
    }
}

// Кастомный стиль кнопки с анимацией масштабирования
struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}