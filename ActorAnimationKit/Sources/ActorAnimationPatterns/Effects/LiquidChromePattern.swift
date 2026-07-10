import SwiftUI
import ActorAnimationCore

public struct LiquidChromePattern: View {
    public let sliderValue: Double
    @State private var phase: CGFloat = 0

    public init(sliderValue: Double) {
        self.sliderValue = sliderValue
    }

    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        colors: [
                            Color(hue: sliderValue, saturation: 0.6, brightness: 1.0),
                            Color(hue: (sliderValue + 0.15).truncatingRemainder(dividingBy: 1.0), saturation: 0.8, brightness: 0.95),
                            Color(hue: (sliderValue + 0.3).truncatingRemainder(dividingBy: 1.0), saturation: 0.9, brightness: 0.85),
                            Color(hue: (sliderValue + 0.15).truncatingRemainder(dividingBy: 1.0), saturation: 0.7, brightness: 0.95),
                            Color(hue: sliderValue, saturation: 0.5, brightness: 1.0),
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(0.6),
                                    Color.white.opacity(0.1),
                                    Color.white.opacity(0.4),
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            ),
                            lineWidth: 2
                        )
                )
                .frame(width: 180, height: 180)

            Image(systemName: "drop.fill")
                .font(.system(size: 44))
                .foregroundStyle(.white.opacity(0.85))
                .blur(radius: CGFloat(sliderValue * 4))
        }
        .scaleEffect(1.0 + CGFloat(sliderValue) * 0.05)
        .onAppear {
            withAnimation(.easeInOut(duration: 3.0).repeatForever(autoreverses: true)) {
                phase = 1
            }
        }
        .animation(AnimationCurves.springSmooth, value: sliderValue)
    }
}

#Preview {
    LiquidChromePattern(sliderValue: 0.5)
}
