//
//  User.swift
//  Marketplace
//
//  Created by Vahan Muradyan on 20.11.25.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let email: String
    let username: String
    let createdAt: Date
    var profileImageUrl: String?
    var totalSales: Double
    var itemsSold: Int
    var itemsPurchased: Int
    
    private enum CodingKeys: String, CodingKey {
        case id
        case email
        case username
        case createdAt = "created_at"
        case profileImageUrl = "profile_image_url"
        case totalSales = "total_sales"
        case itemsSold = "items_sold_count"
        case itemsPurchased = "items_purchased_count"
    }
}

// MARK - Utility

extension User {
    static let mock = User(id: UUID().uuidString,
                           email: "test@gmail.com",
                           username: "test_user",
                           createdAt: Date(),
                           profileImageUrl: "https://picsum.photos/200/200",
                           totalSales: 0,
                           itemsSold: 0,
                           itemsPurchased: 0)
}
