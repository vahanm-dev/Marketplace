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
        
        let publicUrl = "\(Constants.projectURLString)/storage/v1/object/public/avatars/\(path)"
        return publicUrl
    }
}
