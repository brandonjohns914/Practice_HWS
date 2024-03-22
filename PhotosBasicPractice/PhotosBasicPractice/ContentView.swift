import PhotosUI
import SwiftUI

struct ContentView: View {
    @State private var selectedImage: Image?
    @State private var selectedItem: PhotosPickerItem?
    let context = CIContext()
    var body: some View {
        VStack {
            PhotosPicker(selection: $selectedItem) {
                if let selectedImage {
                    selectedImage
                        .resizable()
                        .scaledToFit()
                        .frame(idealWidth: 100, idealHeight: 100)
                } else {
                    ContentUnavailableView("No Picture", systemImage: "photo.badge.plus", description: Text("Tap to import a photo"))
                }
            }
            .onChange(of: selectedItem, loadImage)
        }
    }
    
    func loadImage() {
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else {return}
            
            guard let inputImage = UIImage(data: imageData) else { return }
            
      
            
            
            selectedImage = Image(uiImage: inputImage)
        }
    }
    
}
