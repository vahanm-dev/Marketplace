//
//  ListingFeedViewModel.swift
//  Marketplace
//
//  Created by Vahan Muradyan on 12.12.25.
//

import Foundation

@Observable
final class ListingFeedViewModel {
    // MARK: - Properties
    
    var listings: [Listing] = []
    
    private let service: ListingService
    
    // MARK: - Special methods
    
    init(service: ListingService = ListingService()) {
        self.service = service
    }
}

// MARK: - Public API

extension ListingFeedViewModel {
    func fetchListing() async {
        do {
            self.listings = try await service.fetchListings()
        } catch {
            print("DEBUG: Failed to fetch listings with error: \(error.localizedDescription)")
        }
    }
}
