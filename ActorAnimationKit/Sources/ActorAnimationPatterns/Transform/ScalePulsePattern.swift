import SwiftUI
import ActorAnimationCore

public struct ScalePulsePattern: View {
    public let tapTrigger: Int
    @State private var scale: CGFloat = 1.0
    @State private var opacity: Double = 1.0

    public init(tapTrigger: Int) {
        self.tapTrigger = tapTrigger
    }

    public var body: some View {
        Image(systemName: "bell.fill")
            .font(.system(size: 80))
            .foregroundStyle(AppColors.accent)
            .scaleEffect(scale)
            .opacity(opacity)
            .onChange(of: tapTrigger) { _, _ in
                pulse()
            }
            .onTapGesture { pulse() }
    }

    private func pulse() {
        withAnimation(AnimationCurves.springBouncy) {
            scale = 1.4
            opacity = 0.6
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation(AnimationCurves.springSmooth) {
                scale = 1.0
                opacity = 1.0
            }
        }
    }
}

#Preview {
    ScalePulsePattern(tapTrigger: 0)
}
