//
//  ListingFeedView.swift
//  Marketplace
//
//  Created by Vahan Muradyan on 12.12.25.
//

import SwiftUI

struct ListingFeedView: View {
    @State private var viewModel = ListingFeedViewModel()
    @State private var selectedCategory: Listing.Category? = nil
    
    private let columns = [GridItem(.adaptive(minimum: 170), spacing: 0)]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                // categories view
                Section {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            // all button
                            Button { selectedCategory = nil } label: {
                                BadgeView(title: "All",
                                          isSelected: selectedCategory == nil)
                            }
                            
                            // categories
                            ForEach(Listing.Category.allCases) { category in
                                Button { selectedCategory = category } label: {
                                    BadgeView(
                                        title: category.displayName,
                                        isSelected: selectedCategory == category
                                    )
                                }
                            }
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                    }
                }
                
                // feed view
                Section {
                    LazyVGrid(columns: columns, alignment: .center, spacing: 24) {
                        ForEach(filteringListings) { listing in
                            ListingFeedCell(listing: listing)
                        }
                    }
                    .animation(.smooth, value: selectedCategory)
                }
                .padding(.vertical, 8)
            }
            .navigationTitle("Marketplace")
        }
        .task { await viewModel.fetchListing() }
    }
}

// MARK: - Private API

private extension ListingFeedView {
    var filteringListings: [Listing] {
        return selectedCategory == nil ? viewModel.listings :
        viewModel.listings.filter { $0.category == selectedCategory }
    }
}

// MARK: - Preview

#Preview {
    ListingFeedView()
}
