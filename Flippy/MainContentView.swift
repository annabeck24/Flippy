
import SwiftUI
import PhotosUI

struct MainContentView: View {
    @Binding var isImagePickerPresented: Bool
    @Binding var isImagesSaved: Bool
    @Binding var selectedImages: [RotatableImage]
    
    var body: some View {
        ZStack {
            Color.white // Full-screen white background

            VStack {
                Text("Flippy")
                    .font(.system(size: 40, design: .monospaced))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .kerning(2.2)
                    .padding(.top, 8) // Adjust top padding as needed
                    .padding(.bottom, 20) // Adjust bottom padding as needed
                
                ScrollView(.horizontal, showsIndicators: true) {
                    HStack(spacing: 10) { // Adjust spacing between images
                        ForEach(selectedImages) { rotatableImage in
                            Image(uiImage: rotatableImage.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 200) // Adjust frame size as needed
                                .rotationEffect(.degrees(rotatableImage.rotationAngle))
                                .background(Color.white)
                        }
                    }
                    .padding(.horizontal, 20) // Add horizontal padding
                }
                .background(Color.white)
                .cornerRadius(10)
//                .shadow(radius: 5)
                .padding(.bottom, 20) // Add spacing below ScrollView

                if selectedImages.isEmpty {
                    Button("Select Photos") {
                        isImagePickerPresented = true
                    }
                    .padding()
                    .font(.system(size: 15, design: .monospaced))
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }

                if !selectedImages.isEmpty && !isImagesSaved {
                    Button("Flip Photos") {
                        flipAllPhotos()
                    }
                    .padding()
                    .font(.system(size: 15, design: .monospaced))
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(10)

                    Button("Save Photos") {
                        saveAllPhotos()
                        isImagesSaved = true
                    }
                    .padding()
                    .font(.system(size: 15, design: .monospaced))
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }

                if isImagesSaved {
                    Button("Images Saved! Flip More Images") {
                        reset()
                    }
                    .padding()
                    .font(.system(size: 15, design: .monospaced))
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
            .padding()
        }
        .edgesIgnoringSafeArea(.all) // Extend the background color to edges
        .sheet(isPresented: $isImagePickerPresented) {
            PhotoPicker(selectedImages: $selectedImages)
        }
    }

    func flipAllPhotos() {
        for index in selectedImages.indices {
            selectedImages[index].rotationAngle += 90
            if selectedImages[index].rotationAngle == 360 {
                selectedImages[index].rotationAngle = 0
            }
        }
    }

    func saveAllPhotos() {
        for rotatableImage in selectedImages {
            let rotatedImage = rotateImage(image: rotatableImage.image, by: rotatableImage.rotationAngle)
            saveImageToCameraRoll(image: rotatedImage)
        }
    }

    func rotateImage(image: UIImage, by angle: Double) -> UIImage {
        let radians = angle * .pi / 180
        var newSize = CGRect(origin: CGPoint.zero, size: image.size)
            .applying(CGAffineTransform(rotationAngle: CGFloat(radians)))
            .size
        newSize.width = floor(newSize.width)
        newSize.height = floor(newSize.height)

        UIGraphicsBeginImageContextWithOptions(newSize, false, image.scale)
        let context = UIGraphicsGetCurrentContext()!

        context.translateBy(x: newSize.width / 2, y: newSize.height / 2)
        context.rotate(by: CGFloat(radians))
        image.draw(in: CGRect(x: -image.size.width / 2, y: -image.size.height / 2, width: image.size.width, height: image.size.height))

        let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return rotatedImage!
    }

    func saveImageToCameraRoll(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }

    func reset() {
        isImagesSaved = false
        selectedImages.removeAll()
    }
}
