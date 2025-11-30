//
//  UserService.swift
//  Marketplace
//
//  Created by Vahan Muradyan on 20.11.25.
//

import Foundation
import Supabase

struct UserService {
    // MARK: - Properties
    
    private let client: SupabaseClient
    
    // MARK: - Special methods
    
    init() {
        client = SupabaseClient(supabaseURL: URL(string: Constants.projectURLString)!,
                                supabaseKey: Constants.projectAPIKey)
    }
}

// MARK: - Public API

extension UserService {
    func fetchCurrentUser() async throws -> User {
        let supabaseUser = try await client.auth.session.user
        
        return try await client.from("users")
            .select()
            .eq("id", value: supabaseUser.id.uuidString)
            .single()
            .execute()
            .value
    }
    
    func uploadProfileImageURL(_ imageURL: String) async throws {
        let uid = try await client.auth.session.user.id.uuidString
        
        try await client
            .from("users")
            .update(["profile_image_url": imageURL])
            .eq("id", value: uid)
            .execute()
    }
}
