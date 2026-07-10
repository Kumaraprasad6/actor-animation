import SwiftUI
import ActorAnimationCore

public struct MarqueePattern: View {
    public let toggleValue: Bool
    @State private var offset: CGFloat = 0

    public init(toggleValue: Bool) {
        self.toggleValue = toggleValue
    }

    public var body: some View {
        GeometryReader { geo in
            let text = "SwiftUI Marquee Animation • Scroll Forever • "
            let trailing = "SwiftUI Marquee Animation • Scroll Forever • "

            HStack(spacing: 0) {
                Text(text)
                    .font(.system(size: 22, weight: .semibold, design: .rounded))
                    .foregroundStyle(AppColors.accent)
                Text(trailing)
                    .font(.system(size: 22, weight: .semibold, design: .rounded))
                    .foregroundStyle(AppColors.accent)
            }
            .offset(x: toggleValue ? offset : 0)
            .onAppear {
                if toggleValue { startMarquee() }
            }
            .onChange(of: toggleValue) { _, isOn in
                if isOn {
                    startMarquee()
                }
            }
        }
        .frame(height: 60)
        .padding(.horizontal)
    }

    private func startMarquee() {
        offset = 0
        withAnimation(.linear(duration: 6.0).repeatForever(autoreverses: false)) {
            offset = -400
        }
    }
}

#Preview {
    MarqueePattern(toggleValue: true)
}
