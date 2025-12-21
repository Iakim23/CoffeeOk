//
//  CoffeeShop.swift
//  CoffeeOk
//
//  Created by Iakim Boiunets on 18/12/2025.
//

import Foundation

struct CoffeeShop: Identifiable, Codable {
    let id: String
    let name: String
    let avatar: String?
    let address: String?
    let city: String?
    let description: String?
    let categories: String?
    let rating: Double?
    let isPartner: Bool
    let loyaltyEnabled: Bool
    let galleryImage: String?
    let workingHours: String?
    let isOpenNow: Bool?
    let closesAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case avatar
        case address
        case city
        case description
        case categories
        case rating
        case isPartner
        case loyaltyEnabled
        case galleryImage
        case workingHours
        case isOpenNow
        case closesAt
    }
}


