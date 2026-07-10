import SwiftUI
import ActorAnimationCore

public struct PerspectiveTiltPattern: View {
    @Binding public var dragOffset: CGSize

    public init(dragOffset: Binding<CGSize>) {
        _dragOffset = dragOffset
    }

    public var body: some View {
        VStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 16)
                .fill(
                    LinearGradient(
                        colors: [AppColors.accent.opacity(0.4), AppColors.accent.opacity(0.1)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .overlay(
                    VStack(spacing: 10) {
                        Image(systemName: "rotate.3d")
                            .font(.system(size: 44))
                        Text("Drag to tilt")
                            .font(AppTypography.headline())
                    }
                    .foregroundStyle(AppColors.accent)
                )
                .frame(width: 180, height: 140)
                .rotation3DEffect(
                    .degrees(Double(dragOffset.width) / 3),
                    axis: (0, 1, 0),
                    perspective: 0.5
                )
                .rotation3DEffect(
                    .degrees(Double(-dragOffset.height) / 3),
                    axis: (1, 0, 0),
                    perspective: 0.5
                )
        }
        .gesture(
            DragGesture()
                .onChanged { value in
                    dragOffset = value.translation
                }
                .onEnded { _ in
                    withAnimation(AnimationCurves.springBouncy) {
                        dragOffset = .zero
                    }
                }
        )
        .animation(AnimationCurves.springSmooth, value: dragOffset)
    }
}

#Preview {
    PerspectiveTiltPattern(dragOffset: .constant(.zero))
}
