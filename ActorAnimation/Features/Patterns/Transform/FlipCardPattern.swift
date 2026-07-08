import SwiftUI

struct FlipCardPattern: View {
    let tapTrigger: Int
    @State private var isFlipped = false

    var body: some View {
        ZStack {
            cardFront
                .opacity(isFlipped ? 0 : 1)
            cardBack
                .opacity(isFlipped ? 1 : 0)
                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
        }
        .rotation3DEffect(
            .degrees(isFlipped ? 180 : 0),
            axis: (x: 0, y: 1, z: 0),
            perspective: 0.4
        )
        .onChange(of: tapTrigger) { _, _ in
            withAnimation(AnimationCurves.springSmooth) {
                isFlipped.toggle()
            }
        }
        .onTapGesture {
            withAnimation(AnimationCurves.springSmooth) {
                isFlipped.toggle()
            }
        }
    }

    private var cardFront: some View {
        VStack(spacing: 12) {
            Image(systemName: "questionmark.circle.fill")
                .font(.system(size: 50))
            Text("Tap to flip")
                .font(AppTypography.headline())
        }
        .foregroundStyle(AppColors.accent)
        .frame(width: 180, height: 120)
        .background(AppColors.secondaryBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    private var cardBack: some View {
        VStack(spacing: 12) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 50))
            Text("Flipped!")
                .font(AppTypography.headline())
        }
        .foregroundStyle(.green)
        .frame(width: 180, height: 120)
        .background(AppColors.secondaryBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    FlipCardPattern(tapTrigger: 0)
}