//
//  SupabaseAuthService.swift
//  Marketplace
//
//  Created by Vahan Muradyan on 20.11.25.
//

import Foundation
import Supabase

struct SupabaseAuthService {
    // MARK: - Properties
    
    private let client: SupabaseClient
    
    // MARK: - Special methods
    
    init() {
        // to-do: force cast !!!
        client = SupabaseClient(supabaseURL: URL(string: Constants.projectURLString)!,
                                supabaseKey: Constants.projectAPIKey)
    }
}

// MARK: - Public API

extension SupabaseAuthService {
    func signOut() async throws {
        try await client.auth.signOut()
    }
    
    func signUp(email: String, password: String, username: String) async throws -> String {
        let response = try await client.auth.signUp(email: email, password: password)
        let userId = response.user.id.uuidString
        // to-do: upload user data here
        return userId
    }
    
    func signIn(email: String, password: String) async throws -> String {
        let response = try await client.auth.signIn(email: email, password: password)
        return response.user.id.uuidString
    }
    
    func getCurrentUserSession() async throws -> String? {
        let supabaseUser = try await client.auth.session.user
        return supabaseUser.id.uuidString
    }
}
