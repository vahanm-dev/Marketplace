//
//  CreateListingView.swift
//  Marketplace
//
//  Created by Vahan Muradyan on 05.12.25.
//

import SwiftUI
import PhotosUI

struct CreateListingView: View {
    @State private var title = ""
    @State private var price = ""
    @State private var description = ""
    @State private var selectedCategory: Listing.Category = .other
    
    @State private var pickedPhotoItems: [PhotosPickerItem] = []
    @State private var selectedImages: [UIImage] = []
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Details") {
                    TextField("Title", text: $title)
                    
                    TextField("Price", text: $price)
                        .keyboardType(.decimalPad)
                    
                    Picker("Category", selection: $selectedCategory) {
                        ForEach(Listing.Category.allCases) { category in
                            Text(category.displayName)
                                .tag(category)
                        }
                    }
                }
                
                Section("Description") {
                    TextEditor(text: $description)
                        .frame(height: 120)
                        .overlay (
                            Group {
                                if description.isEmpty {
                                    Text("Describe your listing...")
                                        .foregroundStyle(.secondary)
                                        .padding(.top, 8)
                                        .padding(.leading, 4)
                                }
                            },
                            alignment: .topLeading
                        )
                }
                
                Section("Photos") {
                    VStack(alignment: .leading) {
                        ListingImagesView(
                            pickedPhotoItems: $pickedPhotoItems,
                            selectedImages: $selectedImages
                        )
                    }
                    
                    Divider()
                    
                    Text("You can add up to 5 photos.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                        .padding(.vertical, 4)
                }
            }
            .navigationTitle("New Listing")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        //
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Post") {
                        //
                    }
                }
            }
        }
    }
}

#Preview {
    CreateListingView()
}
