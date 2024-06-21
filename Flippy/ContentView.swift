import SwiftUI
import PhotosUI

struct RotatableImage: Identifiable, Hashable {
    let id = UUID()
    var image: UIImage
    var rotationAngle: Double = 0
}

struct ContentView: View {
    @State private var isImagePickerPresented = false
    @State private var isImagesSaved = false
    @State private var selectedImages: [RotatableImage] = []
    @State private var showSplashScreen = true
    
    var body: some View {
        Group {
            if showSplashScreen {
                SplashScreen()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                            withAnimation {
                                showSplashScreen = false
                            }
                        }
                    }
            } else {
                MainContentView(isImagePickerPresented: $isImagePickerPresented, isImagesSaved: $isImagesSaved, selectedImages: $selectedImages)
            }
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
