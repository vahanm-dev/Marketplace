//
//  CreateListingService.swift
//  Marketplace
//
//  Created by Vahan Muradyan on 05.12.25.
//

import Foundation
import Supabase

struct CreateListingService {
    private let client: SupabaseClient
    
    init() {
        self.client = SupabaseClient(
            supabaseURL: URL(string: Constants.projectURLString)!,
            supabaseKey: Constants.projectAPIKey
        )
    }
    
    func createListing(
        title: String,
        description: String,
        price: Double,
        category: Listing.Category,
        imageData: [Data],
        seller: User
    ) async throws {
        var listing = Listing(
            id: UUID().uuidString,
            title: title,
            description: description,
            price: price,
            imageUrls: [],
            category: category,
            createdAt: Date(),
            likesCount: 0,
            status: .active,
            isFavorite: false,
            sellerID: seller.id,
            sellerName: seller.username,
            sellerProfileImageUrl: seller.profileImageUrl
        )
        
        let imageUrls = try await uploadImages(for: listing, data: imageData)
        listing.imageUrls = imageUrls
        
        try await client.from("listings").insert(listing).execute()
    }
    
    private func uploadImages(for listing: Listing, data: [Data]) async throws -> [String] {
        let manager = StorageManager()
        var result = [String]()
        
        // to-do: use task group and upload asynchronously
        for (index, data) in data.enumerated() {
            let imageUrl = try await manager.uploadListingPhoto(for: listing, imageData: data, index: index)
            result.append(imageUrl)
        }
        
        return result
    }
}
