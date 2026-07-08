import Foundation

enum AnimationCategory: String, CaseIterable, Identifiable, Hashable {
    case transform
    case transition
    case gesture
    case shape
    case timer
    case gradient
    case effects

    var id: String { rawValue }

    var title: String {
        switch self {
        case .transform: "Transform"
        case .transition: "Transition"
        case .gesture: "Gesture"
        case .shape: "Shape"
        case .timer: "Timer"
        case .gradient: "Gradient"
        case .effects: "Effects"
        }
    }

    var systemImageName: String {
        switch self {
        case .transform: "arrow.up.left.and.arrow.down.right"
        case .transition: "rectangle.dashed"
        case .gesture: "hand.tap"
        case .shape: "scribble.variable"
        case .timer: "clock.arrow.circlepath"
        case .gradient: "paintpalette"
        case .effects: "sparkles"
        }
    }
}