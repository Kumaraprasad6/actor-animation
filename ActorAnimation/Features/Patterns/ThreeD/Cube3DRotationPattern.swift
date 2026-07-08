import SwiftUI

struct Cube3DRotationPattern: View {
    let sliderValue: Double

    private var xAngle: Double { sliderValue * 360 }
    private var yAngle: Double { sliderValue * 720 }

    var body: some View {
        ZStack {
            Cube3D(xAngle: xAngle, yAngle: yAngle, size: 120)
        }
        .frame(width: 240, height: 240)
        .animation(AnimationCurves.springSmooth, value: sliderValue)
    }
}

private struct Cube3D: View {
    let xAngle: Double
    let yAngle: Double
    let size: CGFloat

    var body: some View {
        ZStack {
            face(.front, offset: .zero, rotation: .identity)
            face(.back, offset: .zero, rotation: .init(angle: .degrees(180), axis: (0, 1, 0)))
            face(.right, offset: CGSize(width: size / 2, height: 0), rotation: .init(angle: .degrees(90), axis: (0, 1, 0)))
            face(.left, offset: CGSize(width: -size / 2, height: 0), rotation: .init(angle: .degrees(-90), axis: (0, 1, 0)))
            face(.top, offset: CGSize(width: 0, height: -size / 2), rotation: .init(angle: .degrees(90), axis: (1, 0, 0)))
            face(.bottom, offset: CGSize(width: 0, height: size / 2), rotation: .init(angle: .degrees(-90), axis: (1, 0, 0)))
        }
        .rotation3DEffect(.degrees(yAngle), axis: (0, 1, 0), perspective: 0.5)
        .rotation3DEffect(.degrees(xAngle), axis: (1, 0, 0), perspective: 0.5)
    }

    private func face(_ label: CubeFace, offset: CGSize, rotation: Rotation3D) -> some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(label.color.opacity(0.5))
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.white.opacity(0.8), lineWidth: 2)
            )
            .overlay(
                Text(label.text)
                    .font(.title3.weight(.bold))
                    .foregroundStyle(.white)
            )
            .frame(width: size, height: size)
            .offset(offset)
            .rotation3DEffect(rotation.angle, axis: rotation.axis)
    }
}

private enum CubeFace {
    case front, back, left, right, top, bottom

    var color: Color {
        switch self {
        case .front: .blue
        case .back: .purple
        case .left: .orange
        case .right: .green
        case .top: .pink
        case .bottom: .teal
        }
    }

    var text: String {
        switch self {
        case .front: "F"
        case .back: "B"
        case .left: "L"
        case .right: "R"
        case .top: "T"
        case .bottom: "D"
        }
    }
}

private struct Rotation3D {
    let angle: Angle
    let axis: (x: CGFloat, y: CGFloat, z: CGFloat)

    static var identity: Rotation3D {
        Rotation3D(angle: .zero, axis: (x: 0, y: 0, z: 1))
    }

    init(angle: Angle, axis: (CGFloat, CGFloat, CGFloat)) {
        self.angle = angle
        self.axis = (x: axis.0, y: axis.1, z: axis.2)
    }
}

#Preview {
    Cube3DRotationPattern(sliderValue: 0.3)
}