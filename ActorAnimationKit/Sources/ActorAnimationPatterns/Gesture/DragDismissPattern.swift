import SwiftUI
import ActorAnimationCore

public struct DragDismissPattern: View {
    @Binding public var dragOffset: CGSize

    public init(dragOffset: Binding<CGSize>) {
        _dragOffset = dragOffset
    }

    public var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "envelope.fill")
                .font(.system(size: 60))
                .foregroundStyle(AppColors.accent)
            Text("Drag me")
                .font(AppTypography.headline())
                .foregroundStyle(AppColors.secondaryText)
        }
        .frame(width: 200, height: 160)
        .background(AppColors.secondaryBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .offset(dragOffset)
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
    DragDismissPattern(dragOffset: .constant(.zero))
}
