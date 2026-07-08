import SwiftUI

struct AnimatedGradientMeshPattern: View {
    let sliderValue: Double
    @State private var animateGradient = false

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(
                    LinearGradient(
                        colors: [
                            Color(hue: sliderValue, saturation: 0.8, brightness: 0.9),
                            Color(hue: (sliderValue + 0.33).truncatingRemainder(dividingBy: 1.0), saturation: 0.8, brightness: 0.9),
                            Color(hue: (sliderValue + 0.66).truncatingRemainder(dividingBy: 1.0), saturation: 0.8, brightness: 0.9),
                            Color(hue: sliderValue, saturation: 0.8, brightness: 0.9),
                        ],
                        startPoint: animateGradient ? .topLeading : .bottomTrailing,
                        endPoint: animateGradient ? .bottomTrailing : .topLeading
                    )
                )
                .frame(width: 200, height: 200)

            Image(systemName: "circle.grid.3x3.fill")
                .font(.system(size: 48))
                .foregroundStyle(.white.opacity(0.85))
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 3.0).repeatForever(autoreverses: true)) {
                animateGradient = true
            }
        }
        .animation(AnimationCurves.easeStandard, value: sliderValue)
    }
}

#Preview {
    AnimatedGradientMeshPattern(sliderValue: 0.5)
}