import SwiftUI

struct ProgressArcPattern: View {
    let sliderValue: Double

    var body: some View {
        ZStack {
            Circle()
                .stroke(AppColors.secondaryBackground, lineWidth: 18)
                .frame(width: 160, height: 160)

            Circle()
                .trim(from: 0, to: max(sliderValue, 0.001))
                .stroke(
                    AngularGradient(
                        colors: [.teal, .blue, .teal],
                        center: .center
                    ),
                    style: StrokeStyle(lineWidth: 18, lineCap: .round)
                )
                .frame(width: 160, height: 160)
                .rotationEffect(.degrees(-90))

            VStack(spacing: 4) {
                Text("\(Int(sliderValue * 100))%")
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .foregroundStyle(AppColors.accent)
                Text("Progress")
                    .font(AppTypography.caption())
                    .foregroundStyle(AppColors.secondaryText)
            }
        }
        .animation(AnimationCurves.springSmooth, value: sliderValue)
    }
}

#Preview {
    ProgressArcPattern(sliderValue: 0.5)
}