//
//  Comment.swift
//  CoffeeOk
//
//  Created by Iakim Boiunets on 18/12/2025.
//

import Foundation

struct Comment: Identifiable {
    let id: String
    let text: String
    let author: User
    let createdAt: Date
    let likes: Int
    
    init(id: String, text: String, author: User, createdAt: Date = Date(), likes: Int = 0) {
        self.id = id
        self.text = text
        self.author = author
        self.createdAt = createdAt
        self.likes = likes
    }
}

