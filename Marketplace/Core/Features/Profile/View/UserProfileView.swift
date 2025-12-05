//
//  UserProfileView.swift
//  Marketplace
//
//  Created by Vahan Muradyan on 20.11.25.
//

import SwiftUI
import PhotosUI

struct UserProfileView: View {
    @State private var showPhotosPicker = false
    @State private var selectedItem: PhotosPickerItem?
    @State private var profileImage: Image?
    
    @Environment(AuthManager.self) private var authManager
    @Environment(UserManager.self) private var userManager
    
    var body: some View {
        NavigationStack {
            List {
                if let currentUser = userManager.currentUser {
                    Section {
                        HStack(spacing: 12) {
                            AvatarView(
                                imageUrl: currentUser.profileImageUrl,
                                size: .large,
                                profileImage: profileImage
                            ) {
                                showPhotosPicker = true
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            Text(currentUser.username)
                            
                            Text(currentUser.email)
                                .foregroundStyle(.secondary)
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
        .photosPicker(isPresented: $showPhotosPicker, selection: $selectedItem)
        .task(id: selectedItem) { await onImageSelected() }
    }
}

// MARK: - Private API

private extension UserProfileView {
    func onImageSelected() async {
        guard let selectedItem else { return }
        guard let user = userManager.currentUser else { return }
        
        do {
            guard let data = try await selectedItem.loadTransferable(type: Data.self)
            else { return }
            guard let uiImage = UIImage(data: data) else { return }
            guard let imageData = uiImage.jpegData(compressionQuality: 0.5) else { return }
            
            profileImage = Image(uiImage: uiImage)
            
            let imageUrl = try await StorageManager().uploadProfilePhoto(for: user, imageData: imageData)
            await userManager.updateProfileImageURL(imageUrl)
            
        } catch {
            print("DEBUG: Failed to upload image data: \(error.localizedDescription)")
        }
    }
}

// MARK: - Preview

#Preview {
    UserProfileView()
        .environment(AuthManager())
        .environment(UserManager())
}
