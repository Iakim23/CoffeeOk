//
//  User.swift
//  CoffeeOk
//
//  Created by Iakim Boiunets on 18/12/2025.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let name: String
    let avatar: String?
    let bio: String?
    let city: String?
    let joinedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case avatar
        case bio
        case city
        case joinedAt
    }
}



