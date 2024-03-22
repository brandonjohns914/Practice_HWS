//
//  PickerNeedsToRotate.swift
//  PhotosBasicPractice
//
//  Created by Brandon Johns on 3/15/24.
//

import SwiftUI
import PhotosUI
struct PickerNeedsToRotate: View {
    @State private var pickerItem: PhotosPickerItem?
    @State private var selectedImage: Image?
    let context = CIContext()
    var body: some View {
        VStack {
            VStack {
                PhotosPicker(selection: $pickerItem) {
                    if let selectedImage {
                        selectedImage
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                    } else {
                        ContentUnavailableView("No Picture", systemImage: "photo.badge.plus", description: Text("Tap to import a photo"))
                    }
                    
                }
            }
            .onChange(of: pickerItem) {
                Task {
                    if let loaded = try? await pickerItem?.loadTransferable(type: Image.self) {
                        selectedImage = loaded
                    } else {
                        print("Failed")
                    }
                }
            }
        }
    }
    
    
}

#Preview {
    PickerNeedsToRotate()
}
