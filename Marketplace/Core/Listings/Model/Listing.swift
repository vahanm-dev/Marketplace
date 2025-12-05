//
//  Listing.swift
//  Marketplace
//
//  Created by Vahan Muradyan on 05.12.25.
//

import Foundation

struct Listing: Identifiable, Codable, Hashable {
    let id: String
    var title: String
    var description: String
    var price: Double
    var imageUrls: [String]
    var category: Category
    let createdAt: Date
    var likesCount: Int
    var status: Status
    var isFavorite: Bool
    
    var sellerID: String
    var sellerName: String
    var sellerProfileImageUrl: String?
    
    var buyerId: String?
    var buyerName: String?
    var buyerProfileImageUrl: String?
    var purchasedAt: Date?
    
    enum Category: String, Codable, CaseIterable, Identifiable {
        case electronics
        case fashion
        case home
        case sports
        case automotive
        case beauty
        case appliances
        case other
        
        var id: String { rawValue }
        
        var displayName: String {
            switch self {
            case .electronics: return "Electronics"
            case .fashion: return "Fashion"
            case .home: return "Home"
            case .sports: return "Sports"
            case .automotive: return "Automotive"
            case .beauty: return "Beauty"
            case .appliances: return "Appliances"
            case .other: return "Other"
            }
        }
    }
    
    enum Status: String, Codable {
        case inactive
        case active
        case purchased
    }
    
    mutating func updateAsPurchasedBy(buyerId: String) {
        self.status = .purchased
        self.buyerId = buyerId
        self.purchasedAt = Date()
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case price
        case imageUrls = "image_urls"
        case category
        case createdAt = "created_at"
        case likesCount = "likes_count"
        case status
        case isFavorite = "is_favorite"
        
        case sellerID = "seller_id"
        case sellerName = "seller_name"
        case sellerProfileImageUrl = "seller_profile_image_url"
        
        case buyerId = "buyer_id"
        case buyerName = "buyer_name"
        case buyerProfileImageUrl = "buyer_profile_image_url"
        case purchasedAt = "purchased_at"
    }
}

extension Listing {
    static let mock: Listing =
    Listing(
        id: "1",
        title: "Air Pods",
        description: "Brand new AirPods, never used. Got different head phones instead. Comes with case.",
        price: 150,
        imageUrls: ["air-pods", "air-pods-2"],
        category: .electronics,
        createdAt: Date(),
        likesCount: 4,
        status: .active,
        isFavorite: false,
        sellerID: UUID().uuidString,
        sellerName: "Sam Smith",
        sellerProfileImageUrl: "https://picsum.photos/100/100",
    )
    
    static func mocks(count: Int = 5) -> [Listing] {
        return [
            Listing(
                id: "1",
                title: "Air Pods",
                description: "Brand new AirPods, never used. Got different head phones instead. Comes with case.",
                price: 150,
                imageUrls: ["air-pods", "air-pods-2"],
                category: .electronics,
                createdAt: Date(),
                likesCount: 4,
                status: .active,
                isFavorite: false,
                sellerID: UUID().uuidString,
                sellerName: "Sam Smith",
                sellerProfileImageUrl: "https://picsum.photos/100/100",
            ),
            Listing(
                id: "2",
                title: "iPhone",
                description: "Brand new iPhone, never used. Got different head phones instead. Comes with case and charger.",
                price: 320,
                imageUrls: ["iphone"],
                category: .electronics,
                createdAt: Date(),
                likesCount: 4,
                status: .active,
                isFavorite: false,
                sellerID: UUID().uuidString,
                sellerName: "Sam Smith",
                sellerProfileImageUrl: "https://picsum.photos/100/100",
            ),
            Listing(
                id: "3",
                title: "Mac Book Pro",
                description: "Brand new Mac Book Pro, never used. Upgraded to a new model and don't need this one anymore. Comes with charger",
                price: 699,
                imageUrls: ["macbook"],
                category: .electronics,
                createdAt: Date(),
                likesCount: 5,
                status: .active,
                isFavorite: false,
                sellerID: UUID().uuidString,
                sellerName: "Sam Smith",
                sellerProfileImageUrl: "https://picsum.photos/100/100",
            )
        ]
    }
}
