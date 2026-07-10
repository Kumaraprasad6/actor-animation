import Foundation

public enum AnimationCategory: String, CaseIterable, Identifiable, Hashable, Sendable {
    case transform
    case transition
    case gesture
    case shape
    case timer
    case gradient
    case effects
    case threeD

    public var id: String { rawValue }

    public var title: String {
        switch self {
        case .transform: "Transform"
        case .transition: "Transition"
        case .gesture: "Gesture"
        case .shape: "Shape"
        case .timer: "Timer"
        case .gradient: "Gradient"
        case .effects: "Effects"
        case .threeD: "3D"
        }
    }

    public var systemImageName: String {
        switch self {
        case .transform: "arrow.up.left.and.arrow.down.right"
        case .transition: "rectangle.dashed"
        case .gesture: "hand.tap"
        case .shape: "scribble.variable"
        case .timer: "clock.arrow.circlepath"
        case .gradient: "paintpalette"
        case .effects: "sparkles"
        case .threeD: "cube.transparent"
        }
    }
}
