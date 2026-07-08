import Foundation

enum AnimationInput: String, CaseIterable, Identifiable, Hashable {
    case tap
    case drag
    case pinch
    case swipe
    case slider
    case toggle

    var id: String { rawValue }

    var title: String {
        switch self {
        case .tap: "Tap"
        case .drag: "Drag"
        case .pinch: "Pinch"
        case .swipe: "Swipe"
        case .slider: "Slider"
        case .toggle: "Toggle"
        }
    }

    var systemImageName: String {
        switch self {
        case .tap: "hand.tap.fill"
        case .drag: "hand.draw.fill"
        case .pinch: "hand.pinch.fill"
        case .swipe: "arrow.left.and.right"
        case .slider: "sliders.horizontal.3"
        case .toggle: "switch.2"
        }
    }
}