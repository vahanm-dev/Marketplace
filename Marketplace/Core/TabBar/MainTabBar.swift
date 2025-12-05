//
//  MainTabBar.swift
//  Marketplace
//
//  Created by Vahan Muradyan on 05.12.25.
//

import SwiftUI

enum TabIdentifier: Hashable {
    case feed
    case createListing
    case notifications
    case profile
}

struct MainTabBar: View {
    @State private var selectedTab: TabIdentifier = .feed
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Feed", systemImage: "house", value: TabIdentifier.feed) {
                Text("Feed View")
            }
            
            Tab("Sell", systemImage: "plus.circle", value: TabIdentifier.createListing) {
                CreateListingView()
            }
            
            Tab("Notifications", systemImage: "heart", value: TabIdentifier.notifications) {
                Text("Notifications View")
            }
            
            Tab("Profile", systemImage: "person", value: TabIdentifier.profile) {
                UserProfileView()
            }
        }
    }
}

#Preview {
    MainTabBar()
        .environment(AuthManager())
        .environment(UserManager())
}
