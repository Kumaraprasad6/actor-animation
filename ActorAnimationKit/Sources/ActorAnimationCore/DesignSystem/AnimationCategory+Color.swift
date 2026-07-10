import SwiftUI

public extension AnimationCategory {
    var color: Color {
        switch self {
        case .transform: .blue
        case .transition: .purple
        case .gesture: .orange
        case .shape: .teal
        case .timer: .indigo
        case .gradient: .pink
        case .effects: .green
        case .threeD: .cyan
        }
    }
}
