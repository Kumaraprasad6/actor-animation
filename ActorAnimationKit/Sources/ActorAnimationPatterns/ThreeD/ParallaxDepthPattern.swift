import SwiftUI
import ActorAnimationCore

public struct ParallaxDepthPattern: View {
    public let sliderValue: Double

    public init(sliderValue: Double) {
        self.sliderValue = sliderValue
    }

    public var body: some View {
        ZStack {
            layer(color: .blue.opacity(0.3), size: 200, offset: 0, depth: 0.2)
            layer(color: .teal.opacity(0.4), size: 160, offset: 1, depth: 0.4)
            layer(color: .purple.opacity(0.5), size: 120, offset: 2, depth: 0.6)
            layer(color: .orange.opacity(0.6), size: 80, offset: 3, depth: 0.8)
            layer(color: .pink.opacity(0.8), size: 40, offset: 4, depth: 1.0)
        }
        .frame(width: 240, height: 240)
        .animation(AnimationCurves.springSmooth, value: sliderValue)
    }

    private func layer(color: Color, size: CGFloat, offset: Int, depth: Double) -> some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(color)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.white.opacity(0.5), lineWidth: 1)
            )
            .frame(width: size, height: size)
            .offset(
                x: CGFloat(offset) * CGFloat(sliderValue - 0.5) * 40 * depth,
                y: CGFloat(offset) * CGFloat(sliderValue - 0.5) * 40 * depth
            )
            .scaleEffect(1.0 + CGFloat(sliderValue - 0.5) * CGFloat(depth) * 0.2)
    }
}

#Preview {
    ParallaxDepthPattern(sliderValue: 0.5)
}
