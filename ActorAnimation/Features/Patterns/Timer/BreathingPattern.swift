import SwiftUI

struct BreathingPattern: View {
    let toggleValue: Bool
    @State private var isBreathing = false

    var body: some View {
        ZStack {
            Circle()
                .fill(RadialGradient(
                    colors: [AppColors.accent.opacity(0.6), AppColors.accent.opacity(0.05)],
                    center: .center,
                    startRadius: 10,
                    endRadius: 100
                ))
                .frame(width: 160, height: 160)
                .scaleEffect(toggleValue ? (isBreathing ? 1.2 : 0.75) : 1.0)
                .opacity(toggleValue ? (isBreathing ? 0.9 : 0.3) : 1.0)
                .animation(
                    toggleValue
                        ? .easeInOut(duration: 2.0).repeatForever(autoreverses: true)
                        : nil,
                    value: isBreathing
                )

            Text(toggleValue ? "Breathing" : "Paused")
                .font(AppTypography.headline())
                .foregroundStyle(AppColors.accent)
        }
        .onChange(of: toggleValue) { _, newValue in
            isBreathing = newValue
        }
        .onAppear {
            isBreathing = toggleValue
        }
    }
}

#Preview {
    BreathingPattern(toggleValue: true)
}