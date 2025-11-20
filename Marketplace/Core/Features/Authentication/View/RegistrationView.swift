//
//  RegistrationView.swift
//  Marketplace
//
//  Created by Vahan Muradyan on 20.11.25.
//

import SwiftUI

struct RegistrationView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(AuthManager.self) private var authManager
    
    @State private var email = ""
    @State private var username = ""
    @State private var password = ""
    @State private var confirmedPassword = ""
    @State private var passwordsMatch = false
    @State private var isLoading = false
    
    var body: some View {
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
                
                TextField("Enter your username", text: $username)
                    .textInputAutocapitalization(.none)
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal, 24)
                
                ZStack(alignment: .trailing) {
                    SecureField("Enter your password", text: $password)
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    if !password.isEmpty && !confirmedPassword.isEmpty {
                        Image(systemName: passwordsMatch ? "checkmark.circle.fill" : "xmark.circle.fill")
                            .foregroundStyle(passwordsMatch ? .green : .red)
                            .padding(.horizontal)
                    }
                }
                .padding(.horizontal, 24)
                
                ZStack(alignment: .trailing) {
                    SecureField("Confirm your password", text: $confirmedPassword)
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    if !password.isEmpty && !confirmedPassword.isEmpty {
                        Image(systemName: passwordsMatch ? "checkmark.circle.fill" : "xmark.circle.fill")
                            .foregroundStyle(passwordsMatch ? .green : .red)
                            .padding(.horizontal)
                    }
                }
                .padding(.horizontal, 24)
                .onChange(of: confirmedPassword) { oldValue, newValue in
                    passwordsMatch = newValue == password
                }
            }
            
            Button { signUp() } label: {
                Text("Sign Up")
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
            
            Button { dismiss() } label: {
                HStack(spacing: 3) {
                    Text("Already have an account")
                    
                    Text("Sign In")
                        .fontWeight(.semibold)
                }
                .font(.subheadline)
            }
            .padding(.vertical, 16)
        }
    }
}

// MARK: - Private API

private extension RegistrationView {
    var formIsValid: Bool {
        email.isValidEmail() && passwordsMatch && username.count > 1
    }
    
    func signUp() {
        Task {
            isLoading = true
            await authManager.signUp(email: email, password: password, username: username)
            isLoading = false
        }
    }
}

// MARK: - Preview

#Preview {
    RegistrationView()
}
