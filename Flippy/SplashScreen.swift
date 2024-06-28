import SwiftUI
import PhotosUI


struct SplashScreen: View {
    @State private var opacity: Double = 1.0
    @State private var scale: CGFloat = 1.0

    var body: some View {
        ZStack {
            Color.green
                .edgesIgnoringSafeArea(.all)

            Text("PhotoFlippy")
                .font(.system(size: 35, design: .monospaced))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .kerning(2.2)
                .scaleEffect(scale)
        }
        .opacity(opacity)
        .onAppear {
            withAnimation(.easeInOut(duration: 4)) {
                opacity = 0.0
                scale = 1.5
            }
        }
    }
}
