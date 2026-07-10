import SwiftUI
import ActorAnimationCore

public struct HueRainbowFlowPattern: View {
    public let sliderValue: Double
    @State private var rotation: Double = 0

    public init(sliderValue: Double) {
        self.sliderValue = sliderValue
    }

    public var body: some View {
        ZStack {
            Circle()
                .fill(
                    AngularGradient(
                        colors: [
                            .red, .orange, .yellow, .green, .blue, .purple, .pink, .red
                        ],
                        center: .center,
                        angle: .degrees(rotation)
                    )
                )
                .frame(width: 180, height: 180)

            Circle()
                .fill(AppColors.card)
                .frame(width: 80, height: 80)

            Text("\(Int(sliderValue * 360))°")
                .font(AppTypography.mono(18))
                .foregroundStyle(AppColors.primaryText)
        }
        .rotationEffect(.degrees(sliderValue * 360))
        .animation(AnimationCurves.springSmooth, value: sliderValue)
    }
}

#Preview {
    HueRainbowFlowPattern(sliderValue: 0.5)
}
