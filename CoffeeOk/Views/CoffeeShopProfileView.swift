//
//  CoffeeShopProfileView.swift
//  CoffeeOk
//
//  Created by Iakim Boiunets on 18/12/2025.
//

import SwiftUI

struct CoffeeShopProfileView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State private var isSubscribed = false
    let shopId: String
    
    private var shop: CoffeeShop? {
        MockData.coffeeShops.first { $0.id == shopId }
    }
    
    private var shopPosts: [Post] {
        MockData.posts.filter { post in
            if case .coffeeShop(let shop) = post.author {
                return shop.id == shopId
            }
            return false
        }
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            if let shop = shop {
                VStack(spacing: 0) {
                    ScrollView {
                        LazyVStack(spacing: 0) {
                            // Главное изображение
                            ZStack(alignment: .top) {
                                AsyncImage(url: URL(string: shop.avatar ?? "")) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                } placeholder: {
                                    Color(hex: "2a2a2a")
                                }
                                .frame(height: 320)
                                .clipped()
                                
                                // Градиент снизу
                                LinearGradient(
                                    colors: [.clear, .black],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                                .frame(height: 120)
                                .offset(y: 200)
                            }
                            .frame(height: 320)
                            
                            // Контент
                            VStack(alignment: .leading, spacing: 24) {
                                // Название и категория
                                VStack(alignment: .leading, spacing: 12) {
                                    // Название кофейни
                                    Text(shop.name)
                                        .font(.system(size: 28, weight: .bold))
                                        .foregroundColor(.white)
                                        .lineLimit(2)
                                    
                                    // Категория
                                    if let categories = shop.categories {
                                        Text(categories)
                                            .font(.system(size: 15))
                                            .foregroundColor(Color(hex: "aeaeb2"))
                                    }
                                    
                                    // Кнопки действий
                                    HStack(spacing: 12) {
                                        Button(action: {
                                            isSubscribed.toggle()
                                        }) {
                                            Text(isSubscribed ? "Отписаться" : "Подписаться")
                                                .font(.system(size: 16, weight: .semibold))
                                                .foregroundColor(.white)
                                                .frame(maxWidth: .infinity)
                                                .frame(height: 48)
                                                .background(Color(hex: "8c2e6c"))
                                                .cornerRadius(14)
                                                .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
                                        }
                                        
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
                                }
                                .padding(.horizontal, 20)
                                .padding(.top, 24)
                                
                                // Карточка с деталями
                                VStack(spacing: 16) {
                                    // Адрес
                                    HStack(alignment: .top, spacing: 12) {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 10)
                                                .fill(Color(hex: "c4c4c4").opacity(0.16))
                                                .frame(width: 32, height: 32)
                                            
                                            Image(systemName: "mappin.circle.fill")
                                                .font(.system(size: 16))
                                                .foregroundColor(.white)
                                        }
                                        
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text("Адрес")
                                                .font(.system(size: 15, weight: .semibold))
                                                .foregroundColor(.white)
                                            
                                            VStack(alignment: .leading, spacing: 0) {
                                                if let address = shop.address {
                                                    Text(address)
                                                        .font(.system(size: 14))
                                                        .foregroundColor(Color(hex: "aeaeb2"))
                                                }
                                                if let city = shop.city {
                                                    Text(city)
                                                        .font(.system(size: 14))
                                                        .foregroundColor(Color(hex: "aeaeb2"))
                                                }
                                            }
                                        }
                                        
                                        Spacer()
                                    }
                                    
                                    Divider()
                                        .background(Color.white.opacity(0.05))
                                    
                                    // Время работы
                                    HStack(alignment: .top, spacing: 12) {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 10)
                                                .fill(Color(hex: "414143"))
                                                .frame(width: 32, height: 32)
                                            
                                            Image(systemName: "clock.fill")
                                                .font(.system(size: 16))
                                                .foregroundColor(.white)
                                        }
                                        
                                        VStack(alignment: .leading, spacing: 4) {
                                            HStack {
                                                Text(shop.isOpenNow == true ? "Открыто сейчас" : "Закрыто")
                                                    .font(.system(size: 15, weight: .semibold))
                                                    .foregroundColor(.white)
                                                
                                                Spacer()
                                                
                                                if let closesAt = shop.closesAt {
                                                    Text("До \(closesAt)")
                                                        .font(.system(size: 14))
                                                        .foregroundColor(.white)
                                                }
                                            }
                                            
                                            if let workingHours = shop.workingHours {
                                                Text(workingHours)
                                                    .font(.system(size: 14))
                                                    .foregroundColor(Color(hex: "aeaeb2"))
                                            } else {
                                                Text("Ежедневно 08:00 – 23:00")
                                                    .font(.system(size: 14))
                                                    .foregroundColor(Color(hex: "aeaeb2"))
                                            }
                                        }
                                    }
                                }
                                .padding(20)
                                .background(
                                    LinearGradient(
                                        colors: [Color(hex: "1c1c1e"), Color(hex: "2c2c2e")],
                                        startPoint: .bottom,
                                        endPoint: .top
                                    )
                                )
                                .cornerRadius(20)
                                .shadow(color: .black.opacity(0.25), radius: 25, x: 0, y: 12)
                                .padding(.horizontal, 20)
                                
                                // О месте
                                VStack(alignment: .leading, spacing: 12) {
                                    Text("О месте")
                                        .font(.system(size: 18, weight: .semibold))
                                        .foregroundColor(.white)
                                    
                                    if let description = shop.description {
                                        Text(description)
                                            .font(.system(size: 15))
                                            .foregroundColor(Color(hex: "aeaeb2"))
                                            .lineSpacing(4)
                                            .fixedSize(horizontal: false, vertical: true)
                                    }
                                }
                                .padding(.horizontal, 20)
                                
                                // Последние посты
                                VStack(alignment: .leading, spacing: 16) {
                                    HStack {
                                        Text("Последние посты")
                                            .font(.system(size: 18, weight: .semibold))
                                            .foregroundColor(.white)
                                        
                                        Spacer()
                                        
                                        Text("Все (124)")
                                            .font(.system(size: 14, weight: .medium))
                                            .foregroundColor(Color(hex: "8a8887"))
                                    }
                                    .padding(.horizontal, 20)
                                    
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack(spacing: 12) {
                                            ForEach(Array(shopPosts.prefix(3))) { post in
                                                PostPreviewCard(post: post)
                                            }
                                        }
                                        .padding(.horizontal, 20)
                                    }
                                }
                                .padding(.bottom, 100)
                            }
                        }
                    }
                }
                .overlay(
                    // Кнопки навигации - фиксированы относительно safe area
                    GeometryReader { geometry in
                        HStack {
                            // Кнопка назад - слева
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
                            
                            Spacer()
                            
                            // Кнопка меню - справа
                            Button(action: {}) {
                                ZStack {
                                    Circle()
                                        .fill(Color(hex: "1c1c1e").opacity(0.6))
                                        .frame(width: 40, height: 40)
                                    
                                    Image(systemName: "ellipsis")
                                        .font(.system(size: 20, weight: .semibold))
                                        .foregroundColor(.white)
                                }
                            }
                            .padding(.trailing, 20)
                            .padding(.top, geometry.safeAreaInsets.top + 12)
                        }
                    },
                    alignment: .top
                )
            } else {
                Text("Кофейня не найдена")
                    .foregroundColor(.gray)
            }
        }
        .preferredColorScheme(.dark)
        .onAppear {
            // Загружаем состояние подписки из данных
        }
    }
}

struct PostPreviewCard: View {
    let post: Post
    
    private let cardWidth: CGFloat = 160
    private var cardHeight: CGFloat {
        cardWidth * 1.25 // Сохраняем пропорции 200/160 = 1.25
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .bottomLeading) {
                AsyncImage(url: URL(string: post.imageUrl ?? "")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Color(hex: "2a2a2a")
                }
                .frame(width: cardWidth, height: cardHeight)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                
                // Бейдж с лайками (только если есть лайки)
                if post.likes > 0 {
                    HStack(spacing: 4) {
                        Image(systemName: "heart.fill")
                            .font(.system(size: 12))
                            .foregroundColor(.white)
                        Text("\(post.likes)")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(
                        Color.black.opacity(0.5)
                            .background(.ultraThinMaterial)
                    )
                    .cornerRadius(8)
                    .padding(8)
                }
            }
            
            // Автор поста
            HStack(spacing: 8) {
                AsyncImage(url: URL(string: post.author.avatar ?? "")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Color(hex: "333")
                }
                .frame(width: 24, height: 24)
                .clipShape(Circle())
                
                Text(post.author.name)
                    .font(.system(size: 13))
                    .foregroundColor(Color(hex: "aeaeb2"))
                    .lineLimit(1)
            }
        }
        .frame(width: cardWidth)
    }
}

