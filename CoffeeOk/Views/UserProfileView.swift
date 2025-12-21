//
//  UserProfileView.swift
//  CoffeeOk
//
//  Created by Iakim Boiunets on 18/12/2025.
//

import SwiftUI

struct UserProfileView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State private var isSubscribed = false
    @State private var searchText = ""
    let userId: String
    
    private var user: User? {
        MockData.users.first { $0.id == userId }
    }
    
    private var userPosts: [Post] {
        let posts = MockData.posts.filter { $0.author.id == userId }
        if searchText.isEmpty {
            return posts
        }
        return posts.filter { post in
            (post.text?.localizedCaseInsensitiveContains(searchText) ?? false)
        }
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            if let user = user {
                VStack(spacing: 0) {
                    ScrollView {
                        VStack(spacing: 24) {
                            // Профиль пользователя
                            VStack(spacing: 20) {
                                // Аватар
                                AsyncImage(url: URL(string: user.avatar ?? "")) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                } placeholder: {
                                    Circle()
                                        .fill(Color.gray.opacity(0.3))
                                }
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                
                                // Имя
                                Text(user.name)
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundColor(.white)
                                
                                // Кнопки действий
                                HStack(spacing: 12) {
                                    // Кнопка подписки (фиолетовая)
                                    Button(action: {
                                        isSubscribed.toggle()
                                    }) {
                                        Text(isSubscribed ? "Подписан" : "Подписаться...")
                                            .font(.system(size: 16, weight: .semibold))
                                            .foregroundColor(.white)
                                            .frame(maxWidth: .infinity)
                                            .frame(height: 48)
                                            .background(Color(hex: "8c2e6c"))
                                            .cornerRadius(14)
                                            .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
                                    }
                                    
                                    // Кнопка поделиться
                                    Button(action: {}) {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 14)
                                                .fill(Color(hex: "1c1c1e"))
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 14)
                                                        .stroke(Color.white.opacity(0.1), lineWidth: 1)
                                                )
                                            
                                            Image(systemName: "square.and.arrow.up")
                                                .font(.system(size: 20))
                                                .foregroundColor(.white)
                                                .rotationEffect(.degrees(45))
                                        }
                                        .frame(width: 48, height: 48)
                                    }
                                }
                                .padding(.horizontal, 16)
                                
                                // Информация о пользователе
                                VStack(alignment: .leading, spacing: 0) {
                                    if let bio = user.bio {
                                        InfoRow(label: "bio", value: bio)
                                        Divider()
                                            .background(Color(hex: "#2a2a2a"))
                                    }
                                    
                                    if let city = user.city {
                                        InfoRow(label: "city", value: city)
                                        Divider()
                                            .background(Color(hex: "#2a2a2a"))
                                    }
                                    
                                    if let joinedAt = user.joinedAt {
                                        InfoRow(label: "joined_at", value: joinedAt)
                                    }
                                }
                                .background(Color(hex: "#1a1a1a"))
                                .cornerRadius(12)
                                .padding(.horizontal, 16)
                            }
                            .padding(.top, 60)
                            
                            // Посты автора
                            VStack(alignment: .leading, spacing: 16) {
                                Text("Посты автора:")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 16)
                                
                                // Поисковая строка
                                HStack(spacing: 12) {
                                    HStack(spacing: 8) {
                                        Image(systemName: "magnifyingglass")
                                            .foregroundColor(.gray)
                                            .font(.system(size: 16))
                                        
                                        TextField("Search", text: $searchText)
                                            .foregroundColor(.white)
                                            .font(.system(size: 16))
                                    }
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 10)
                                    .background(Color(hex: "#1a1a1a"))
                                    .cornerRadius(10)
                                    
                                    // Кнопка фильтра
                                    Button(action: {}) {
                                        Image(systemName: "line.3.horizontal.decrease.circle")
                                            .font(.system(size: 20))
                                            .foregroundColor(.gray)
                                            .frame(width: 44, height: 44)
                                            .background(Color(hex: "#1a1a1a"))
                                            .cornerRadius(10)
                                    }
                                }
                                .padding(.horizontal, 16)
                                
                                // Список постов
                                ForEach(userPosts) { post in
                                    PostCard(post: post)
                                        .padding(.horizontal, 16)
                                }
                            }
                            .padding(.bottom, 20)
                        }
                    }
                }
                .overlay(
                    // Кнопка назад - фиксирована в левом верхнем углу
                    GeometryReader { geometry in
                        Button(action: {
                            viewModel.goBack()
                        }) {
                            ZStack {
                                Circle()
                                    .fill(Color(hex: "1c1c1e").opacity(0.6))
                                    .frame(width: 40, height: 40)
                                
                                Image(systemName: "chevron.left")
                                    .font(.system(size: 20, weight: .semibold))
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(.leading, 18)
                        .padding(.top, geometry.safeAreaInsets.top + 14)
                    },
                    alignment: .topLeading
                )
            } else {
                Text("Пользователь не найден")
                    .foregroundColor(.gray)
            }
        }
    }
    
    struct InfoRow: View {
        let label: String
        let value: String
        
        var body: some View {
            HStack(spacing: 12) {
                Text(label)
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                
                Spacer()
                
                Text(value)
                    .font(.system(size: 16))
                    .foregroundColor(.white)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
        }
    }
}


