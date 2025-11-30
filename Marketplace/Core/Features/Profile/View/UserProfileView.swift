//
//  UserProfileView.swift
//  Marketplace
//
//  Created by Vahan Muradyan on 20.11.25.
//

import SwiftUI

struct UserProfileView: View {
    @Environment(AuthManager.self) private var authManager
    @Environment(UserManager.self) private var userManager
    
    var body: some View {
        NavigationStack {
            List {
                if let currentUser = userManager.currentUser {
                    Section {
                        HStack {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 72, height: 72)
                                .foregroundStyle(.secondary)
                            
                            VStack(alignment: .leading) {
                                Text(currentUser.username)
                                
                                Text(currentUser.email)
                                    .foregroundStyle(.secondary)
                            }
                            .font(.subheadline)
                            
                        }
                    }
                    
                    Section("Account") {
                        Button("Sign Out", role: .destructive) {
                            Task { await authManager.signOut() }
                        }
                    }
                }
            }
            .navigationTitle("Profile")
        }
    }
}

#Preview {
    UserProfileView()
        .environment(AuthManager())
        .environment(UserManager())
}
