//
//  CreateListingViewModel.swift
//  Marketplace
//
//  Created by Vahan Muradyan on 05.12.25.
//

import Foundation

@Observable
final class CreateListingViewModel {
    private let service: CreateListingService
    
    init(service: CreateListingService) {
        self.service = service
    }
    
    func createListing(
        title: String,
        description: String,
        price: Double,
        category: Listing.Category,
        imageData: [Data],
        seller: User
    ) async throws {
        try await service.createListing(title: title,
                                        description: description,
                                        price: price,
                                        category: category,
                                        imageData: imageData,
                                        seller: seller
        )
    }
}
