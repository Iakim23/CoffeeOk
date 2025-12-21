//
//  PostsView.swift
//  CoffeeOk
//
//  Created by Iakim Boiunets on 18/12/2025.
//

import SwiftUI

struct PostsView: View {
    @EnvironmentObject var viewModel: AppViewModel
    let posts = MockData.posts
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(posts) { post in
                    PostCard(post: post)
                }
            }
            .padding()
        }
        .background(Color.black)
    }
}

struct PostCard: View {
    let post: Post
    @EnvironmentObject var viewModel: AppViewModel
    @State private var isLiked: Bool = false
    @State private var likesCount: Int
    
    init(post: Post) {
        self.post = post
        _likesCount = State(initialValue: post.likes)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Заголовок с автором
            Button(action: {
                navigateToAuthorProfile()
            }) {
                HStack(spacing: 12) {
                    AsyncImage(url: URL(string: post.author.avatar ?? "")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        Circle()
                            .fill(Color.gray.opacity(0.3))
                    }
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(post.author.name)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                        
                        Text(post.createdAt, style: .relative)
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                }
                .contentShape(Rectangle())
            }
            .buttonStyle(PlainButtonStyle())
            .allowsHitTesting(true)
            
            // Текст поста
            if let text = post.text {
                Text(text)
                    .font(.system(size: 15))
                    .foregroundColor(.white)
            }
            
            // Изображение
            if let imageUrl = post.imageUrl {
                AsyncImage(url: URL(string: imageUrl)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                }
                .frame(height: 200)
                .cornerRadius(12)
            }
            
            // Действия
            HStack(spacing: 24) {
                Button(action: {
                    toggleLike()
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: isLiked ? "heart.fill" : "heart")
                        Text("\(likesCount)")
                    }
                    .font(.system(size: 14))
                    .foregroundColor(isLiked ? Color(hex: "8c2e6c") : .gray)
                }
                
                Button(action: {
                    viewModel.selectPost(post.id)
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: "bubble.right")
                        Text("\(post.comments)")
                    }
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                }
                
                Spacer()
            }
        }
        .padding()
        .background(Color(hex: "#1a1a1a"))
        .cornerRadius(12)
    }
    
    private func toggleLike() {
        if isLiked {
            // Убираем лайк
            isLiked = false
            likesCount -= 1
        } else {
            // Добавляем лайк
            isLiked = true
            likesCount += 1
        }
    }
    
    private func navigateToAuthorProfile() {
        switch post.author {
        case .user(let user):
            viewModel.selectUser(user.id)
        case .coffeeShop(let shop):
            viewModel.selectShop(shop.id)
        }
    }
}

