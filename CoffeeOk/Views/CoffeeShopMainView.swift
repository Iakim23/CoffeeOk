//
//  CoffeeShopMainView.swift
//  CoffeeOk
//
//  Created by Iakim Boiunets on 22/12/2025.
//

import SwiftUI
import UIKit

struct CoffeeShopMainView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State private var selectedTab: CoffeeShopTab = .home

    var body: some View {
        ZStack {
            Color(hex: "#0e0e11").ignoresSafeArea()

            VStack(spacing: 0) {
                // Основной контент с табами
                TabView(selection: $selectedTab) {
                    // Вкладка Инсайты (Аналитика)
                    AnalyticsTabView()
                        .tag(CoffeeShopTab.analytics)

                    // Вкладка Витрина
                    CoffeeShopShowcaseView()
                        .tag(CoffeeShopTab.home)

                    // Вкладка Люди (Отзывы)
                    ReviewsTabView()
                        .tag(CoffeeShopTab.reviews)

                    // Вкладка Уведомления (Профиль)
                    NotificationsTabView()
                        .tag(CoffeeShopTab.profile)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .ignoresSafeArea()

                // Нижняя навигационная панель для кофейни
                CoffeeShopNavBar(selectedTab: $selectedTab)
                    .environmentObject(viewModel)
            }
        }
    }
}

// Вкладка Аналитика
struct AnalyticsTabView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Text("Аналитика")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    .padding(.top, 20)

                // Статистика за сегодня
                VStack(alignment: .leading, spacing: 16) {
                    Text("Сегодня")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)

                    HStack(spacing: 16) {
                        AnalyticsCard(
                            title: "Посетители",
                            value: "47",
                            change: "+12%",
                            icon: "person.2.fill",
                            color: Color.blue
                        )

                        AnalyticsCard(
                            title: "Заказы",
                            value: "23",
                            change: "+8%",
                            icon: "cart.fill",
                            color: Color.green
                        )
                    }

                    HStack(spacing: 16) {
                        AnalyticsCard(
                            title: "Выручка",
                            value: "12 450 ₽",
                            change: "+15%",
                            icon: "rublesign.circle.fill",
                            color: Color.purple
                        )

                        AnalyticsCard(
                            title: "Средний чек",
                            value: "541 ₽",
                            change: "+5%",
                            icon: "chart.line.uptrend.xyaxis",
                            color: Color.orange
                        )
                    }
                }
                .padding(.horizontal, 20)

                // График (заглушка)
                VStack(alignment: .leading, spacing: 16) {
                    Text("Посещаемость за неделю")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)

                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(hex: "#1f2937"))
                            .frame(height: 200)

                        Text("График посещаемости")
                            .foregroundColor(.gray)
                            .font(.system(size: 16))
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 100)
            }
        }
    }
}

// Вкладка Люди
struct ReviewsTabView: View {
    @State private var showUserProfile = false
    @State private var selectedUserId = ""

    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 24) {
                    // Заголовок
                    Text("Люди")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 20)
                        .padding(.top, 20)

                    // Список кофеманов
                    VStack(spacing: 12) {
                        CoffeeLoverCard(
                            name: "Анна Петрова",
                            avatar: "person.circle.fill",
                            visitCount: 24,
                            postCount: 8,
                            action: {
                                selectedUserId = "user_anna_petrova"
                                showUserProfile = true
                            }
                        )

                        CoffeeLoverCard(
                            name: "Михаил Иванов",
                            avatar: "person.circle.fill",
                            visitCount: 18,
                            postCount: 5,
                            action: {
                                selectedUserId = "user_mikhail_ivanov"
                                showUserProfile = true
                            }
                        )

                        CoffeeLoverCard(
                            name: "Елена Смирнова",
                            avatar: "person.circle.fill",
                            visitCount: 31,
                            postCount: 12,
                            action: {
                                selectedUserId = "user_elena_smirnova"
                                showUserProfile = true
                            }
                        )

                        CoffeeLoverCard(
                            name: "Дмитрий Козлов",
                            avatar: "person.circle.fill",
                            visitCount: 15,
                            postCount: 3,
                            action: {
                                selectedUserId = "user_dmitry_kozlov"
                                showUserProfile = true
                            }
                        )

                        CoffeeLoverCard(
                            name: "Ольга Морозова",
                            avatar: "person.circle.fill",
                            visitCount: 22,
                            postCount: 7,
                            action: {
                                selectedUserId = "user_olga_morozova"
                                showUserProfile = true
                            }
                        )

                        CoffeeLoverCard(
                            name: "Алексей Соколов",
                            avatar: "person.circle.fill",
                            visitCount: 9,
                            postCount: 2,
                            action: {
                                selectedUserId = "user_alexey_sokolov"
                                showUserProfile = true
                            }
                        )
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 100)
                }
            }

            // Модальный экран профиля пользователя
            if showUserProfile {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                    .onTapGesture {
                        showUserProfile = false
                    }

                VStack {
                    Spacer()

                    VStack(spacing: 0) {
                        // Заголовок
                        HStack {
                            Button(action: {
                                showUserProfile = false
                            }) {
                                Image(systemName: "xmark")
                                    .foregroundColor(.white)
                                    .font(.system(size: 20))
                            }

                            Spacer()

                            Text("Профиль пользователя")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.white)

                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 16)
                        .background(Color(hex: "#1f2937"))

                        // Содержимое профиля
                        ScrollView {
                            VStack(spacing: 20) {
                                // Аватар и имя
                                VStack(spacing: 16) {
                                    Image(systemName: "person.circle.fill")
                                        .font(.system(size: 80))
                                        .foregroundColor(Color(hex: "#8AFF8A"))

                                    Text(getUserName(from: selectedUserId))
                                        .font(.system(size: 24, weight: .bold))
                                        .foregroundColor(.white)
                                }
                                .padding(.vertical, 20)

                                // Статистика
                                HStack(spacing: 20) {
                                    VStack(spacing: 8) {
                                        Text(getUserStats(from: selectedUserId).visits)
                                            .font(.system(size: 20, weight: .bold))
                                            .foregroundColor(.white)
                                        Text("визитов")
                                            .font(.system(size: 12))
                                            .foregroundColor(.gray)
                                    }

                                    VStack(spacing: 8) {
                                        Text(getUserStats(from: selectedUserId).posts)
                                            .font(.system(size: 20, weight: .bold))
                                            .foregroundColor(.white)
                                        Text("постов")
                                            .font(.system(size: 12))
                                            .foregroundColor(.gray)
                                    }
                                }
                                .padding(.horizontal, 20)

                                // Кнопки действий
                                VStack(spacing: 12) {
                                    Button(action: {}) {
                                        Text("Отправить сообщение")
                                            .font(.system(size: 16, weight: .semibold))
                                            .foregroundColor(.white)
                                            .frame(maxWidth: .infinity)
                                            .padding(.vertical, 12)
                                            .background(Color(hex: "#8b2d6b"))
                                            .cornerRadius(12)
                                    }

                                    Button(action: {}) {
                                        Text("Посмотреть посты")
                                            .font(.system(size: 16, weight: .semibold))
                                            .foregroundColor(.white)
                                            .frame(maxWidth: .infinity)
                                            .padding(.vertical, 12)
                                            .background(Color(hex: "#374151"))
                                            .cornerRadius(12)
                                    }
                                }
                                .padding(.horizontal, 20)
                            }
                            .padding(.bottom, 100)
                        }
                    }
                    .background(Color(hex: "#0e0e11"))
                    .cornerRadius(20)
                    .frame(height: UIScreen.main.bounds.height * 0.8)
                }
                .transition(.move(edge: .bottom))
                .animation(.easeInOut, value: showUserProfile)
            }
        }
    }
}

// Вкладка Уведомления
struct NotificationsTabView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Text("Уведомления")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    .padding(.top, 20)

                // Список уведомлений
                VStack(spacing: 12) {
                    NotificationCard(
                        title: "Новый заказ",
                        message: "Анна Петрова сделала заказ на 450 ₽",
                        time: "2 мин назад",
                        type: .order
                    )

                    NotificationCard(
                        title: "Новый отзыв",
                        message: "Михаил оставил отзыв о вашей кофейне",
                        time: "15 мин назад",
                        type: .review
                    )

                    NotificationCard(
                        title: "Система",
                        message: "Ваша кофейня набрала 100 просмотров сегодня!",
                        time: "1 час назад",
                        type: .system
                    )
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 100)
            }
        }
    }
}

// Карточка кофемана
struct CoffeeLoverCard: View {
    let name: String
    let avatar: String
    let visitCount: Int
    let postCount: Int
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                // Аватар
                Image(systemName: avatar)
                    .font(.system(size: 40))
                    .foregroundColor(Color(hex: "#8AFF8A"))
                    .frame(width: 50, height: 50)
                    .background(Color(hex: "#2E3F2B"))
                    .clipShape(Circle())

                // Информация
                VStack(alignment: .leading, spacing: 4) {
                    Text(name)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)

                    HStack(spacing: 16) {
                        HStack(spacing: 4) {
                            Image(systemName: "location.fill")
                                .font(.system(size: 12))
                                .foregroundColor(Color(hex: "#8AFF8A"))
                            Text("\(visitCount) визитов")
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                        }

                        HStack(spacing: 4) {
                            Image(systemName: "square.and.pencil")
                                .font(.system(size: 12))
                                .foregroundColor(Color(hex: "#8AFF8A"))
                            Text("\(postCount) постов")
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                        }
                    }
                }

                Spacer()

                // Кнопка взаимодействия
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
                    .font(.system(size: 14))
            }
            .padding(16)
            .background(Color(hex: "#1A1A1A"))
            .cornerRadius(12)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// Карточка уведомления
struct NotificationCard: View {
    let title: String
    let message: String
    let time: String
    let type: NotificationType

    enum NotificationType {
        case order, review, system
    }

    var iconName: String {
        switch type {
        case .order: return "cart.fill"
        case .review: return "star.fill"
        case .system: return "bell.fill"
        }
    }

    var iconColor: Color {
        switch type {
        case .order: return .green
        case .review: return .yellow
        case .system: return .blue
        }
    }

    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(iconColor.opacity(0.2))
                    .frame(width: 40, height: 40)

                Image(systemName: iconName)
                    .foregroundColor(iconColor)
                    .font(.system(size: 16))
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)

                Text(message)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .lineLimit(2)

                Text(time)
                    .font(.system(size: 12))
                    .foregroundColor(.gray.opacity(0.7))
            }

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
                .font(.system(size: 14))
        }
        .padding(16)
        .background(Color(hex: "#1f2937"))
        .cornerRadius(12)
    }
}

// Карточка аналитики
struct AnalyticsCard: View {
    let title: String
    let value: String
    let change: String
    let icon: String
    let color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(color)

            VStack(alignment: .leading, spacing: 4) {
                Text(value)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)

                Text(title)
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
            }

            HStack(spacing: 4) {
                Image(systemName: change.hasPrefix("+") ? "arrow.up.right" : "arrow.down.right")
                    .foregroundColor(change.hasPrefix("+") ? .green : .red)
                    .font(.system(size: 12))

                Text(change)
                    .font(.system(size: 12))
                    .foregroundColor(change.hasPrefix("+") ? .green : .red)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(Color(hex: "#1f2937"))
        .cornerRadius(12)
    }
}

// Вспомогательные функции для ReviewsTabView
func getUserName(from userId: String) -> String {
    switch userId {
    case "user_anna_petrova": return "Анна Петрова"
    case "user_mikhail_ivanov": return "Михаил Иванов"
    case "user_elena_smirnova": return "Елена Смирнова"
    case "user_dmitry_kozlov": return "Дмитрий Козлов"
    case "user_olga_morozova": return "Ольга Морозова"
    case "user_alexey_sokolov": return "Алексей Соколов"
    default: return "Пользователь"
    }
}

func getUserStats(from userId: String) -> (visits: String, posts: String) {
    switch userId {
    case "user_anna_petrova": return ("24", "8")
    case "user_mikhail_ivanov": return ("18", "5")
    case "user_elena_smirnova": return ("31", "12")
    case "user_dmitry_kozlov": return ("15", "3")
    case "user_olga_morozova": return ("22", "7")
    case "user_alexey_sokolov": return ("9", "2")
    default: return ("0", "0")
    }
}

// Вкладка Профиль
struct ProfileTabView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Text("Профиль кофейни")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    .padding(.top, 20)

                // Информация о кофейне
                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Название")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                        Text("Моя кофейня")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Адрес")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                        Text("ул. Ленина, 15, Москва")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Телефон")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                        Text("+7 (495) 123-45-67")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Режим работы")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                        Text("Ежедневно 8:00 - 22:00")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                    }
                }
                .padding(.horizontal, 20)

                // Действия
                VStack(spacing: 12) {
                    ProfileActionButton(
                        title: "Редактировать профиль",
                        icon: "pencil",
                        color: Color(hex: "#374151")
                    )

                    ProfileActionButton(
                        title: "Настройки уведомлений",
                        icon: "bell",
                        color: Color(hex: "#374151")
                    )

                    ProfileActionButton(
                        title: "Поддержка",
                        icon: "questionmark.circle",
                        color: Color(hex: "#374151")
                    )
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 100)
            }
        }
    }
}

// Кнопка действия профиля
struct ProfileActionButton: View {
    let title: String
    let icon: String
    let color: Color

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(color)
                .font(.system(size: 20))
                .frame(width: 24)

            Text(title)
                .font(.system(size: 16))
                .foregroundColor(.white)

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
                .font(.system(size: 14))
        }
        .padding(16)
        .background(Color(hex: "#1f2937"))
        .cornerRadius(12)
    }
}
