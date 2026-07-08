import SwiftUI

struct RotatePattern: View {
    let sliderValue: Double

    var body: some View {
        Image(systemName: "arrow.trianglehead.2.clockwise.rotate.90")
            .font(.system(size: 72))
            .foregroundStyle(AppColors.accent)
            .rotationEffect(.degrees(sliderValue * 360))
            .animation(.easeInOut(duration: 0.5), value: sliderValue)
    }
}

#Preview {
    RotatePattern(sliderValue: 0.5)
}