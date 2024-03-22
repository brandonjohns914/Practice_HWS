//
//  PhotoView.swift
//  PhotosBasicPractice
//
//  Created by Brandon Johns on 3/15/24.
//

import Foundation
import CoreImage
import CoreImage.CIFilterBuiltins
import PhotosUI
import SwiftUI


struct PhotoView: View {
    @State private var inputImage: UIImage?
    @State private var image: Image?
    @State private var showingImagePicker = false
   
    var body: some View {
        VStack {
            VStack {
                image?
                    .resizable()
                    .scaledToFit()
            }
            .onAppear(perform: loadImage)
            Button("Select Image") {
                showingImagePicker = true
            }
            Button("Save Image", action: saveImage)
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage)
        }
        .onChange(of: inputImage) {loadImage()}
        
        
       
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
    
    func saveImage() {
        guard let inputImage = inputImage else { return }

        let imageSaver = ImageSaver()
        imageSaver.writeToPhotoAlbum(image: inputImage)
    }
}



#Preview {
    PhotoView()
}
