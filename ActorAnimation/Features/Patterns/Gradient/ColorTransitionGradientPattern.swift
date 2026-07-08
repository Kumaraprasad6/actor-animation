import SwiftUI

struct ColorTransitionGradientPattern: View {
    let toggleValue: Bool

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        colors: toggleValue
                            ? [Color(red: 0.25, green: 0.6, blue: 0.9), Color(red: 0.15, green: 0.8, blue: 0.7)]
                            : [Color(red: 0.9, green: 0.3, blue: 0.4), Color(red: 0.95, green: 0.55, blue: 0.3)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 200, height: 160)

            VStack(spacing: 8) {
                Image(systemName: toggleValue ? "moon.stars.fill" : "sun.max.fill")
                    .font(.system(size: 40))
                Text(toggleValue ? "Cool" : "Warm")
                    .font(AppTypography.headline())
            }
            .foregroundStyle(.white.opacity(0.9))
        }
        .animation(AnimationCurves.springSmooth, value: toggleValue)
    }
}

#Preview {
    ColorTransitionGradientPattern(toggleValue: false)
}