import SwiftUI
import ActorAnimationCore

public struct RotatePattern: View {
    public let sliderValue: Double

    public init(sliderValue: Double) {
        self.sliderValue = sliderValue
    }

    public var body: some View {
        Image(systemName: "arrow.trianglehead.2.clockwise.rotate.90")
            .font(.system(size: 72))
            .foregroundStyle(AppColors.accent)
            .rotationEffect(.degrees(sliderValue * 360))
            .animation(.easeInOut(duration: 0.5), value: sliderValue)
    }
}

#Preview {
    RotatePattern(sliderValue: 0.5)
}
