import SwiftUI
import ActorAnimationCore

public struct SwipeCardPattern: View {
    @Binding public var swipeDirection: InputControlPanel.SwipeDirection
    @State private var offset: CGFloat = 0
    @State private var rotation: Double = 0

    public init(swipeDirection: Binding<InputControlPanel.SwipeDirection>) {
        _swipeDirection = swipeDirection
    }

    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(AppColors.secondaryBackground)
                .frame(width: 220, height: 280)
                .overlay(
                    VStack(spacing: 16) {
                        Image(systemName: "heart.fill")
                            .font(.system(size: 56))
                            .foregroundStyle(.pink)
                        Text("Swipe me")
                            .font(AppTypography.headline())
                            .foregroundStyle(AppColors.primaryText)
                    }
                )
                .offset(x: offset)
                .rotationEffect(.degrees(rotation))
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            offset = value.translation.width
                            rotation = Double(value.translation.width) / 15
                        }
                        .onEnded { value in
                            if abs(value.translation.width) > 100 {
                                let direction: CGFloat = value.translation.width > 0 ? 1 : -1
                                withAnimation(AnimationCurves.easeStandard) {
                                    offset = direction * 400
                                    rotation = direction * 30
                                }
                                swipeDirection = value.translation.width > 0 ? .right : .left
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                    withAnimation(AnimationCurves.springBouncy) {
                                        offset = 0
                                        rotation = 0
                                    }
                                    swipeDirection = .none
                                }
                            } else {
                                withAnimation(AnimationCurves.springBouncy) {
                                    offset = 0
                                    rotation = 0
                                }
                            }
                        }
                )
                .animation(AnimationCurves.springSmooth, value: offset)
        }
    }
}

#Preview {
    SwipeCardPattern(swipeDirection: .constant(.none))
}
