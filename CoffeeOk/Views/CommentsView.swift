//
//  CommentsView.swift
//  CoffeeOk
//
//  Created by Iakim Boiunets on 18/12/2025.
//

import SwiftUI

struct CommentsView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State private var newCommentText = ""
    @State private var comments: [Comment] = []
    let postId: String
    
    private var post: Post? {
        MockData.posts.first { $0.id == postId }
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            if let post = post {
                VStack(spacing: 0) {
                    ScrollView {
                        VStack(spacing: 0) {
                            // Карточка поста
                            PostHeaderCard(post: post)
                                .padding(.horizontal, 16)
                                .padding(.top, 16)
                            
                            // Разделитель
                            Divider()
                                .background(Color.white.opacity(0.1))
                                .padding(.top, 16)
                            
                            // Список комментариев
                            LazyVStack(spacing: 16) {
                                ForEach(comments) { comment in
                                    CommentRow(comment: comment)
                                }
                            }
                            .padding(.horizontal, 16)
                            .padding(.top, 16)
                            .padding(.bottom, 100)
                        }
                    }
                    
                    // Поле ввода комментария
                    CommentInputView(text: $newCommentText) {
                        addComment()
                    }
                }
            } else {
                Text("Пост не найден")
                    .foregroundColor(.gray)
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
        .onAppear {
            loadComments()
        }
    }
    
    private func loadComments() {
        comments = MockData.getComments(for: postId)
    }
    
    private func addComment() {
        guard !newCommentText.trimmingCharacters(in: .whitespaces).isEmpty,
              let currentUser = MockData.users.first else {
            return
        }
        
        let newComment = Comment(
            id: UUID().uuidString,
            text: newCommentText,
            author: currentUser,
            createdAt: Date(),
            likes: 0
        )
        
        comments.append(newComment)
        newCommentText = ""
    }
}

struct PostHeaderCard: View {
    let post: Post
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Заголовок с автором
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
        }
        .padding()
        .background(Color(hex: "#1a1a1a"))
        .cornerRadius(12)
    }
}

struct CommentRow: View {
    let comment: Comment
    @State private var isLiked = false
    @State private var likesCount: Int
    
    init(comment: Comment) {
        self.comment = comment
        _likesCount = State(initialValue: comment.likes)
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // Аватар автора
            AsyncImage(url: URL(string: comment.author.avatar ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Circle()
                    .fill(Color.gray.opacity(0.3))
            }
            .frame(width: 36, height: 36)
            .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                // Имя автора и время
                HStack(spacing: 8) {
                    Text(comment.author.name)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.white)
                    
                    Text(comment.createdAt, style: .relative)
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
                
                // Текст комментария
                Text(comment.text)
                    .font(.system(size: 14))
                    .foregroundColor(.white)
                    .fixedSize(horizontal: false, vertical: true)
                
                // Кнопка лайка
                Button(action: {
                    toggleLike()
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: isLiked ? "heart.fill" : "heart")
                            .font(.system(size: 12))
                        Text("\(likesCount)")
                            .font(.system(size: 12))
                    }
                    .foregroundColor(isLiked ? Color(hex: "8c2e6c") : .gray)
                }
                .padding(.top, 4)
            }
            
            Spacer()
        }
        .padding(.vertical, 8)
    }
    
    private func toggleLike() {
        if isLiked {
            isLiked = false
            likesCount -= 1
        } else {
            isLiked = true
            likesCount += 1
        }
    }
}

struct CommentInputView: View {
    @Binding var text: String
    let onSend: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            // Поле ввода
            HStack(spacing: 8) {
                TextField("Написать комментарий...", text: $text, axis: .vertical)
                    .foregroundColor(.white)
                    .font(.system(size: 15))
                    .lineLimit(1...4)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color(hex: "#1a1a1a"))
            .cornerRadius(20)
            
            // Кнопка отправки
            Button(action: onSend) {
                Image(systemName: "arrow.up.circle.fill")
                    .font(.system(size: 32))
                    .foregroundColor(text.trimmingCharacters(in: .whitespaces).isEmpty ? .gray : Color(hex: "8c2e6c"))
            }
            .disabled(text.trimmingCharacters(in: .whitespaces).isEmpty)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.black)
    }
}

