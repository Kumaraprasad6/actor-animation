import SwiftUI

struct ShimmerEffectPattern: View {
    let toggleValue: Bool
    @State private var shimmerOffset: CGFloat = -200

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(AppColors.secondaryBackground)
                .frame(width: 200, height: 160)

            VStack(spacing: 12) {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(.systemGray5))
                    .frame(width: 160, height: 16)
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(.systemGray5))
                    .frame(width: 120, height: 12)
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(.systemGray5))
                    .frame(width: 140, height: 12)
            }

            RoundedRectangle(cornerRadius: 16)
                .fill(
                    LinearGradient(
                        colors: [
                            .clear,
                            Color.white.opacity(toggleValue ? 0.5 : 0),
                            .clear,
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .frame(width: 100, height: 160)
                .offset(x: toggleValue ? shimmerOffset : -200)
        }
        .frame(width: 220, height: 180)
        .onChange(of: toggleValue) { _, isOn in
            if isOn {
                shimmer()
            }
        }
        .onAppear {
            if toggleValue { shimmer() }
        }
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    private func shimmer() {
        shimmerOffset = -200
        withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: false)) {
            shimmerOffset = 200
        }
    }
}

#Preview {
    ShimmerEffectPattern(toggleValue: true)
}