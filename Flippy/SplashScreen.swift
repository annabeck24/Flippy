import SwiftUI
import PhotosUI


struct SplashScreen: View {
    var body: some View {
        ZStack {
            Color.green
                .edgesIgnoringSafeArea(.all)

            Text("Flippy")
                .font(.system(size: 35, design: .monospaced))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .kerning(2.2)
        }
    }
}
