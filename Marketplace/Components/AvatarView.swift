//
//  AvatarView.swift
//  Marketplace
//
//  Created by Vahan Muradyan on 30.11.25.
//

import SwiftUI
import Kingfisher

struct AvatarView: View {
    // MARK: - Properties
    
    private let imageUrl: String?
    private let size: AvatarSize
    private let profileImage: Image?
    private let onTap: (() -> Void)?
    
    // MARK: - Special methods
    
    init(imageUrl: String?,
         size: AvatarSize,
         profileImage: Image?,
         onTap: (() -> Void)?)
    {
        self.imageUrl = imageUrl
        self.size = size
        self.profileImage = profileImage
        self.onTap = onTap
    }
}

// MARK: - Body

extension AvatarView {
    var body: some View {
        Group {
            if let profileImage {
                profileImage
                    .resizable()
                    .scaledToFill()
                    .frame(width: size.dimension, height: size.dimension)
                    .clipShape(.circle)
            } else if let imageUrl {
                KFImage(URL(string: imageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: size.dimension, height: size.dimension)
                    .clipShape(.circle)
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: size.dimension, height: size.dimension)
                    .clipShape(.circle)
                    .foregroundStyle(Color(.systemGray6))
            }
        }
        .onTapGesture {
            onTap?()
        }
    }
}

// MARK: - Preview

#Preview {
    AvatarView(imageUrl: nil, size: .medium, profileImage: nil, onTap: nil)
}
