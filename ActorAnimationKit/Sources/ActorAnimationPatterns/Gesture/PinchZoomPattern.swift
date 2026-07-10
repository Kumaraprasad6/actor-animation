import SwiftUI
import ActorAnimationCore

public struct PinchZoomPattern: View {
    @Binding public var pinchScale: CGFloat
    @State private var lastScale: CGFloat = 1.0

    public init(pinchScale: Binding<CGFloat>) {
        _pinchScale = pinchScale
    }

    public var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "magnifyingglass.circle.fill")
                .font(.system(size: 72))
                .foregroundStyle(AppColors.accent)
                .scaleEffect(pinchScale)
            Text("Scale: \(String(format: "%.2f", pinchScale))")
                .font(AppTypography.mono())
                .foregroundStyle(AppColors.secondaryText)
        }
        .gesture(
            MagnificationGesture()
                .onChanged { value in
                    pinchScale = lastScale * value
                }
                .onEnded { _ in
                    lastScale = pinchScale
                    withAnimation(AnimationCurves.springSmooth) {
                        lastScale = 1.0
                        pinchScale = min(max(pinchScale, 0.5), 3.0)
                        lastScale = pinchScale
                    }
                }
        )
        .animation(AnimationCurves.springSmooth, value: pinchScale)
    }
}

#Preview {
    PinchZoomPattern(pinchScale: .constant(1.0))
}
