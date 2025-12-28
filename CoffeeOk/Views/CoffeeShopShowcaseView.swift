//
//  CoffeeShopShowcaseView.swift
//  CoffeeOk
//
//  Created by Iakim Boiunets on 22/12/2025.
//

import SwiftUI
import MapKit

struct CoffeeShopShowcaseView: View {
    @EnvironmentObject var viewModel: AppViewModel

    var body: some View {
        ZStack {
            Color(hex: "#0E0E0E").ignoresSafeArea()

            VStack(spacing: 0) {
                // Navigation bar
                HStack {
                    Spacer()

                    Text("Витрина")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(Color(hex: "#FFFFFF"))

                    Spacer()

                    Button(action: {}) {
                        Image(systemName: "gear")
                            .foregroundColor(Color(hex: "#FFFFFF"))
                            .font(.system(size: 17))
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(Color(hex: "#0E0E0E"))

                // Контент
                ScrollView {
                    VStack(spacing: 16) {
                        // Cover Image
                        ZStack {
                            Image("coffeeshop-header")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 200)
                                .clipped()
                                .cornerRadius(16)

                            // Overlay
                            Color.black.opacity(0.15)
                                .cornerRadius(16)
                        }
                        .padding(.horizontal, 16)

                        // О кофейне
                        ShowcaseCard(
                            title: "О кофейне",
                            isEditable: true,
                            backgroundColor: Color(hex: "#1A1A1A"),
                            content: AnyView(
                                Text("Мы обжариваем зерно сами и делаем кофе, в который верим.")
                                    .foregroundColor(Color(hex: "#B3B3B3"))
                                    .font(.system(size: 14))
                                    .lineSpacing(20 - 14) // lineHeight - fontSize
                            )
                        )

                        // Меню секция
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                Text("Меню")
                                    .font(.system(size: 20, weight: .semibold))
                                    .foregroundColor(.white)

                                Spacer()

                                Button(action: {}) {
                                    Text("view all →")
                                        .foregroundColor(Color(hex: "#8AFF8A"))
                                        .font(.system(size: 14))
                                }
                            }
                            .padding(.horizontal, 16)

                            // Сетка меню 3x2
                            LazyVGrid(columns: [
                                GridItem(.flexible(), spacing: 12),
                                GridItem(.flexible(), spacing: 12),
                                GridItem(.flexible(), spacing: 12)
                            ], spacing: 12) {
                                MenuItemView(title: "capucino", price: "3$", image: "cup.and.saucer.fill")
                                MenuItemView(title: "Ise latte", price: "4$", image: "cup.and.saucer.fill")
                                MenuItemView(title: "Latte", price: "3$", image: "cup.and.saucer.fill")
                                MenuItemView(title: "matcha", price: "2$", image: "cup.and.saucer.fill")
                                MenuItemView(title: "matcha latte", price: "4$", image: "cup.and.saucer.fill")
                                MenuItemView(title: "matcha cap...", price: "3$", image: "cup.and.saucer.fill")
                            }
                            .padding(.horizontal, 16)
                        }

                        // Акции
                        ShowcaseCard(
                            title: "Акции:",
                            isEditable: true,
                            backgroundColor: Color(hex: "#1A1A1A"),
                            content: AnyView(
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Флэт уайт – 2.50 $")
                                        .foregroundColor(.white)
                                        .font(.system(size: 14))
                                    Text("Фильтр дня – 2.80 $")
                                        .foregroundColor(.white)
                                        .font(.system(size: 14))
                                    Text("Капучино – 3 $")
                                        .foregroundColor(.white)
                                        .font(.system(size: 14))
                                }
                            )
                        )

                        // Наш адрес
                        ShowcaseCard(
                            title: "Наш адрес",
                            isEditable: true,
                            backgroundColor: Color(hex: "#1A1A1A"),
                            content: AnyView(
                                Text("ул. Пушкина,\n08:00 — 22:00")
                                    .foregroundColor(Color(hex: "#B3B3B3"))
                                    .font(.system(size: 14))
                            )
                        )

                        // Карта
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(hex: "#1A1A1A"))
                            .frame(height: 180)
                            .overlay(
                                VStack {
                                    Image(systemName: "map")
                                        .font(.system(size: 48))
                                        .foregroundColor(.gray)

                                    Text("Карта")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 16))
                                }
                            )
                            .padding(.horizontal, 16)
                    }
                    .padding(.vertical, 16)
                }
            }
        }
    }
}

// Карточка для секций
struct ShowcaseCard: View {
    let title: String
    let isEditable: Bool
    let backgroundColor: Color
    let content: AnyView

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)

                Spacer()

                if isEditable {
                    Image(systemName: "pencil")
                        .foregroundColor(.gray)
                        .font(.system(size: 14))
                }
            }

            content
        }
        .padding(16)
        .background(backgroundColor)
        .cornerRadius(16)
        .padding(.horizontal, 16)
    }
}

// Элемент меню
struct MenuItemView: View {
    let title: String
    let price: String
    let image: String

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(hex: "#2E3F2B"))
                    .frame(height: 80)

                Image(systemName: image)
                    .font(.system(size: 24))
                    .foregroundColor(Color(hex: "#8AFF8A"))
            }

            VStack(spacing: 4) {
                Text(title)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)

                Text(price)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(Color(hex: "#8AFF8A"))
            }
        }
        .frame(height: 120)
    }
}