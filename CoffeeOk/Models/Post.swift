//
//  Post.swift
//  CoffeeOk
//
//  Created by Iakim Boiunets on 18/12/2025.
//

import Foundation

protocol Author {
    var id: String { get }
    var name: String { get }
    var avatar: String? { get }
}

extension User: Author {}
extension CoffeeShop: Author {}

struct Post: Identifiable {
    let id: String
    let text: String?
    let imageUrl: String?
    let author: PostAuthor
    let likes: Int
    let comments: Int
    let createdAt: Date
    
    init(id: String, text: String?, imageUrl: String?, author: PostAuthor, likes: Int = 0, comments: Int = 0, createdAt: Date = Date()) {
        self.id = id
        self.text = text
        self.imageUrl = imageUrl
        self.author = author
        self.likes = likes
        self.comments = comments
        self.createdAt = createdAt
    }
}

enum PostAuthor {
    case user(User)
    case coffeeShop(CoffeeShop)
    
    var id: String {
        switch self {
        case .user(let user):
            return user.id
        case .coffeeShop(let shop):
            return shop.id
        }
    }
    
    var name: String {
        switch self {
        case .user(let user):
            return user.name
        case .coffeeShop(let shop):
            return shop.name
        }
    }
    
    var avatar: String? {
        switch self {
        case .user(let user):
            return user.avatar
        case .coffeeShop(let shop):
            return shop.avatar
        }
    }
}

