//
//  MarketplaceApp.swift
//  Marketplace
//
//  Created by Vahan Muradyan on 20.11.25.
//

import SwiftUI

@main
struct MarketplaceApp: App {
    @State private var authManager = AuthManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(authManager)
        }
    }
}
