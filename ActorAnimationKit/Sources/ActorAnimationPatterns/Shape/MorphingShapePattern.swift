import SwiftUI
import ActorAnimationCore

public struct MorphingShapePattern: View {
    public let sliderValue: Double

    public init(sliderValue: Double) {
        self.sliderValue = sliderValue
    }

    public var body: some View {
        ZStack {
            MorphShape(progress: sliderValue)
                .fill(LinearGradient(
                    colors: [.teal, .blue],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ))
                .frame(width: 160, height: 160)
        }
        .animation(AnimationCurves.easeStandard, value: sliderValue)
    }
}

private struct MorphShape: Shape {
    let progress: Double

    var animatableData: Double {
        get { progress }
        set { }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let t = progress
        let inset: CGFloat = 20
        let size = min(rect.width, rect.height) - inset * 2
        let center = CGPoint(x: rect.midX, y: rect.midY)

        for i in 0..<5 {
            let angle = (Double(i) / 5) * 2 * .pi - .pi / 2
            let starR = size / 2
            let circleR = size / 2 * 0.7
            let r = lerp(circleR, starR, t)
            let point = CGPoint(
                x: center.x + CGFloat(cos(angle)) * r,
                y: center.y + CGFloat(sin(angle)) * r
            )
            if i == 0 {
                path.move(to: point)
            } else {
                path.addLine(to: point)
            }
        }
        path.closeSubpath()
        return path
    }

    private func lerp(_ a: CGFloat, _ b: CGFloat, _ t: Double) -> CGFloat {
        a + (b - a) * CGFloat(t)
    }
}

#Preview {
    MorphingShapePattern(sliderValue: 0.5)
}
