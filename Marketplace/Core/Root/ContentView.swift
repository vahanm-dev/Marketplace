//
//  ContentView.swift
//  Marketplace
//
//  Created by Vahan Muradyan on 20.11.25.
//

import SwiftUI

struct ContentView: View {
    @Environment(AuthManager.self) private var authManager
    
    var body: some View {
        Group {
            switch authManager.authState {
            case .authenticated:
                Text("Main interface...")
            case .unauthenticated:
                LoginView()
            case .unknown:
                ProgressView()
            }
        }
        .task { await authManager.refreshUser() }
    }
}

#Preview {
    ContentView()
        .environment(AuthManager())
}
