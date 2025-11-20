//
//  UserManager.swift
//  Marketplace
//
//  Created by Vahan Muradyan on 20.11.25.
//

import Foundation

@Observable
final class UserManager {
    // MARK: - Properties
    
    var isLoading = false
    var currentUser: User?
    
    private let service: UserService
    
    // MARK: - Special methods
    
    init(service: UserService = UserService()) {
        self.service = service
    }
}

// MARK: - Public API

extension UserManager {
    func fetchCurrentUser() async {
        isLoading = true
        defer { isLoading = false }
        do {
            currentUser = try await service.fetchCurrentUser()
        } catch {
            print("DEBUG: Failed to fetch current user: \(error)")
        }
    }
}
