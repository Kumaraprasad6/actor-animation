import SwiftUI
import ActorAnimationCore

public struct MatchedGeometryPattern: View {
    public let tapTrigger: Int
    @State private var isExpanded = false
    @Namespace private var namespace

    public init(tapTrigger: Int) {
        self.tapTrigger = tapTrigger
    }

    public var body: some View {
        ZStack {
            if isExpanded {
                RoundedRectangle(cornerRadius: 24)
                    .fill(AppColors.accent.opacity(0.2))
                    .frame(width: 220, height: 220)
                    .overlay(
                        VStack(spacing: 12) {
                            Image(systemName: "wand.and.stars")
                                .font(.system(size: 56))
                            Text("Expanded")
                                .font(AppTypography.headline())
                        }
                        .foregroundStyle(AppColors.accent)
                    )
                    .matchedGeometryEffect(id: "shape", in: namespace)
            } else {
                Circle()
                    .fill(AppColors.accent.opacity(0.2))
                    .frame(width: 100, height: 100)
                    .overlay(
                        Image(systemName: "wand.and.stars")
                            .font(.system(size: 36))
                            .foregroundStyle(AppColors.accent)
                    )
                    .matchedGeometryEffect(id: "shape", in: namespace)
            }
        }
        .onChange(of: tapTrigger) { _, _ in
            withAnimation(AnimationCurves.springBouncy) {
                isExpanded.toggle()
            }
        }
        .onTapGesture {
            withAnimation(AnimationCurves.springBouncy) {
                isExpanded.toggle()
            }
        }
    }
}

#Preview {
    MatchedGeometryPattern(tapTrigger: 0)
}
