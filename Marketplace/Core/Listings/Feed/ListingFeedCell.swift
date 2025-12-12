//
//  ListingFeedCell.swift
//  Marketplace
//
//  Created by Vahan Muradyan on 12.12.25.
//

import SwiftUI
import Kingfisher

struct ListingFeedCell: View {
    let listing: Listing
    
    private let itemWidth: CGFloat = 180.0
    private let itemHeight: CGFloat = 164.0
    
    var body: some View {
        VStack(spacing: 0) {
            if let imageUrl = listing.imageUrls.first {
                KFImage(URL(string: imageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: itemWidth, height: itemHeight)
                    .clipShape(.rect)
            }
            
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 6) {
                    Text(listing.category.displayName)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                    Text(listing.title)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    
                    Text("$\(listing.price.formatted())")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.vertical, 8)
            .padding(.leading, 8)
            .frame(width: itemWidth)
            .background(Color(.systemGroupedBackground))
        }
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .black.opacity(0.2), radius: 4)
    }
}

#Preview {
    ListingFeedCell(listing: Listing.mock)
}
