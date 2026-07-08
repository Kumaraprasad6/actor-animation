import SwiftUI

struct SlideTransitionPattern: View {
    let toggleValue: Bool

    var body: some View {
        ZStack {
            if toggleValue {
                RoundedRectangle(cornerRadius: 16)
                    .fill(AppColors.accent.opacity(0.3))
                    .frame(width: 180, height: 120)
                    .overlay(
                        VStack(spacing: 8) {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.system(size: 40))
                            Text("Shown")
                                .font(AppTypography.headline())
                        }
                        .foregroundStyle(AppColors.accent)
                    )
                    .transition(.move(edge: .trailing).combined(with: .opacity))
            } else {
                RoundedRectangle(cornerRadius: 16)
                    .fill(AppColors.secondaryBackground)
                    .frame(width: 180, height: 120)
                    .overlay(
                        VStack(spacing: 8) {
                            Image(systemName: "circle.dashed")
                                .font(.system(size: 40))
                            Text("Hidden")
                                .font(AppTypography.headline())
                        }
                        .foregroundStyle(AppColors.secondaryText)
                    )
                    .transition(.move(edge: .leading).combined(with: .opacity))
            }
        }
        .animation(AnimationCurves.springSmooth, value: toggleValue)
    }
}

#Preview {
    SlideTransitionPattern(toggleValue: false)
}