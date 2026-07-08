import SwiftUI

struct LoadingSpinnerPattern: View {
    let toggleValue: Bool
    @State private var rotation: Double = 0

    var body: some View {
        ZStack {
            ForEach(0..<8) { i in
                Circle()
                    .fill(toggleValue ? AppColors.accent : AppColors.secondaryText)
                    .frame(width: 16, height: 16)
                    .offset(y: -40)
                    .opacity(toggleValue ? (0.3 + 0.7 * (1.0 - Double(i) / 8.0)) : 0.3)
                    .rotationEffect(.degrees(Double(i) * 45))
                    .rotationEffect(.degrees(rotation))
            }
        }
        .onChange(of: toggleValue) { _, isOn in
            if isOn {
                spin()
            }
        }
        .onAppear {
            if toggleValue { spin() }
        }
        .animation(AnimationCurves.easeStandard, value: toggleValue)
    }

    private func spin() {
        withAnimation(.linear(duration: 1.2).repeatForever(autoreverses: false)) {
            rotation = 360
        }
    }
}

#Preview {
    LoadingSpinnerPattern(toggleValue: true)
}