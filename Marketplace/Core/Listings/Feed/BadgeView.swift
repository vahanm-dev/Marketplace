//
//  BadgeView.swift
//  Marketplace
//
//  Created by Vahan Muradyan on 12.12.25.
//

import SwiftUI

struct BadgeView: View {
    let title: String
    var isSelected: Bool
    var selectedBackground: Color = .blue
    var unselectedBackground: Color = Color(.systemGroupedBackground)
    var selectedForeground: Color = .white
    var unselectedForeground: Color = .primary
    
    var body: some View {
        Text(title)
            .font(.subheadline)
            .fontWeight(.semibold)
            .foregroundStyle(isSelected ? selectedForeground : unselectedForeground)
            .padding(.vertical, 6)
            .padding(.horizontal, 12)
            .background(isSelected ? selectedBackground : unselectedBackground)
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    HStack(spacing: 16) {
        BadgeView(title: "Selected", isSelected: true)
        BadgeView(title: "Unselected", isSelected: false)
    }
    .padding()
}
