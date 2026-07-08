import SwiftUI

struct ScaleFadePattern: View {
    let tapTrigger: Int
    @State private var isShown = false

    var body: some View {
        ZStack {
            Circle()
                .fill(AppColors.accent.opacity(0.15))
                .frame(width: 160, height: 160)

            if isShown {
                VStack(spacing: 12) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 48))
                        .foregroundStyle(.yellow)
                    Text("Scale + Fade")
                        .font(AppTypography.headline())
                        .foregroundStyle(AppColors.accent)
                }
                .transition(
                    .asymmetric(
                        insertion: .scale(scale: 0.3).combined(with: .opacity),
                        removal: .scale(scale: 1.5).combined(with: .opacity)
                    )
                )
            }
        }
        .onChange(of: tapTrigger) { _, _ in
            withAnimation(AnimationCurves.easeStandard) {
                isShown.toggle()
            }
        }
        .onTapGesture {
            withAnimation(AnimationCurves.easeStandard) {
                isShown.toggle()
            }
        }
    }
}

#Preview {
    ScaleFadePattern(tapTrigger: 0)
}