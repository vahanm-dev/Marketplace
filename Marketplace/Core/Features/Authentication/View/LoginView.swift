//
//  LoginView.swift
//  Marketplace
//
//  Created by Vahan Muradyan on 20.11.25.
//

import SwiftUI

struct LoginView: View {
    // MARK: - Properties
    
    @Environment(AuthManager.self) private var authManager
    
    @State private var email = ""
    @State private var password = ""
    @State private var isLoading = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                Image(.supabase)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .padding()
                
                VStack(spacing: 8) {
                    TextField("Enter your email", text: $email)
                        .textInputAutocapitalization(.none)
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.horizontal, 24)
                    
                    SecureField("Enter your password", text: $password)
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.horizontal, 24)
                }
                
                Button { signIn() } label: {
                    Text("Login")
                        .font(.headline)
                        .frame(width: 360, height: 48)
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .foregroundStyle(.white)
                        .padding(.vertical, 8)
                }
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1.0 : 0.5)
                
                Spacer()
                
                Divider()
                
                NavigationLink {
                    RegistrationView()
                        .navigationBarBackButtonHidden()
                } label: {
                    HStack(spacing: 3) {
                        Text("Don't have an account")
                        
                        Text("Sign Up")
                            .fontWeight(.semibold)
                    }
                    .font(.subheadline)
                }
                .padding(.vertical, 16)
            }
        }
    }
}

// MARK: - Private API

private extension LoginView {
    var formIsValid: Bool {
        email.isValidEmail() && !password.isEmpty
    }
    
    func signIn() {
        Task {
            isLoading = true
            await authManager.signIn(email: email, password: password)
            isLoading = false
        }
    }
}

// MARK: - Preview

#Preview {
    LoginView()
        .environment(AuthManager())
}
