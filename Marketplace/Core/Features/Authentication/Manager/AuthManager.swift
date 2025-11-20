//
//  AuthManager.swift
//  Marketplace
//
//  Created by Vahan Muradyan on 20.11.25.
//

import Foundation

@Observable
final class AuthManager {
    // MARK: - Properties
    
    var currentUserId: String?
    var authState: AuthState = .unknown
    
    private let authService: SupabaseAuthService
    
    // MARK: - Special methods
    
    init(authService: SupabaseAuthService = SupabaseAuthService()) {
        self.authService = authService
    }
}

// MARK: - Public API

extension AuthManager {
    func signIn(email: String, password: String) async {
        do {
            currentUserId = try await authService.signIn(email: email, password: password)
            authState = .authenticated
        } catch {
            print("DEBUG: Sign-in error: \(error)")
        }
    }
    
    func signUp(email: String, password: String, username: String) async {
        do {
            currentUserId = try await authService.signUp(email: email, password: password, username: username)
            authState = .authenticated
        } catch {
            print("DEBUG: Sign-up error: \(error)")
        }
    }
    
    func signOut() async {
        do {
            try await authService.signOut()
            currentUserId = nil
            authState = .unauthenticated
        } catch {
            print("DEBUG: Sign-out error: \(error)")
        }
    }
    
    func refreshUser() async {
        do {
            let userSessionId = try await authService.getCurrentUserSession()
            
            if let userSessionId {
                self.authState = .authenticated
                self.currentUserId = userSessionId
            }
        } catch {
            currentUserId = nil
            authState = .unauthenticated
            
            print("DEBUG: Refresh user error: \(error)")
        }
    }
}
