//
//  StorageManager.swift
//  Marketplace
//
//  Created by Vahan Muradyan on 30.11.25.
//

import Foundation
import Supabase

struct StorageManager {
    private let client: SupabaseClient
    
    init() {
        self.client = SupabaseClient(supabaseURL: URL(string: Constants.projectURLString)!,
                                     supabaseKey: Constants.projectAPIKey)
    }
}

// MARK: - Public API

extension StorageManager {
    func uploadProfilePhoto(for user: User, imageData: Data) async throws -> String {
        let path = "\(user.id)/avatar.jpg"
        let fullPath = try await client.storage.from("avatars").upload(path, data: imageData).path
        
        print("DEBUG: Full path is \(fullPath)")
        
        let publicUrl = "\(Constants.projectURLString)/storage/v1/object/public/avatars/\(path)"
        return publicUrl
    }
    
    func uploadListingPhoto(for listing: Listing, imageData: Data, index: Int) async throws -> String {
        let path = "\(listing.id)/\(index).jpg"
        let bucketName = "listing_images"
        
        let fullPath = try await client.storage
            .from(bucketName)
            .upload(path, data: imageData)
            .path
        
        print("DEBUG: Full path is \(fullPath)")
        
        let publicURL = "\(Constants.projectURLString)/storage/v1/object/public/\(bucketName)/\(path)"
        return publicURL
    }
}
