//
//  ListingService.swift
//  Marketplace
//
//  Created by Vahan Muradyan on 12.12.25.
//

import Foundation
import Supabase

struct ListingService {
    // MARK: - Properties
    
    private let client: SupabaseClient
    
    // MARK: - Special methods
    
    init() {
        client = SupabaseClient(supabaseURL: URL(string: Constants.projectURLString)!,
                                supabaseKey: Constants.projectAPIKey)
    }
}

// MARK: - Public API

extension ListingService {
    func fetchListings() async throws -> [Listing] {
        return try await client
            .from("listings")
            .select()
            .eq("status", value: Listing.Status.active.rawValue)
            .execute()
            .value
    }
}
