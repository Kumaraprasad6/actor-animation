import SwiftUI

struct ConicRotationGradientPattern: View {
    let sliderValue: Double
    @State private var rotation: Double = 0

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(
                    AngularGradient(
                        colors: [
                            Color(hue: 0.0, saturation: 0.7, brightness: 1.0),
                            Color(hue: 0.15, saturation: 0.7, brightness: 1.0),
                            Color(hue: 0.3, saturation: 0.7, brightness: 1.0),
                            Color(hue: 0.5, saturation: 0.7, brightness: 1.0),
                            Color(hue: 0.7, saturation: 0.7, brightness: 1.0),
                            Color(hue: 0.85, saturation: 0.7, brightness: 1.0),
                            Color(hue: 1.0, saturation: 0.7, brightness: 1.0),
                        ],
                        center: .center,
                        angle: .degrees(rotation)
                    )
                )
                .frame(width: 200, height: 200)

            Image(systemName: "sparkles")
                .font(.system(size: 44))
                .foregroundStyle(.white.opacity(0.9))
        }
        .onAppear {
            withAnimation(.linear(duration: 8.0).repeatForever(autoreverses: false)) {
                rotation = 360
            }
        }
        .rotationEffect(.degrees(sliderValue * 180))
        .animation(AnimationCurves.springSmooth, value: sliderValue)
    }
}

#Preview {
    ConicRotationGradientPattern(sliderValue: 0.5)
}