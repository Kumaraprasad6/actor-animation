import Foundation
import SwiftUI
import Combine
import ActorAnimationCore

@MainActor
final class PatternDetailViewModel: ObservableObject {
    @Published var tapTrigger = 0
    @Published var sliderValue: Double = 0.5
    @Published var toggleValue = false
    @Published var dragOffset: CGSize = .zero
    @Published var pinchScale: CGFloat = 1.0
    @Published var swipeDirection: InputControlPanel.SwipeDirection = .none

    let pattern: AnimationPattern

    init(pattern: AnimationPattern) {
        self.pattern = pattern
    }

    func resetControls() {
        tapTrigger = 0
        sliderValue = 0.5
        toggleValue = false
        dragOffset = .zero
        pinchScale = 1.0
        swipeDirection = .none
    }
}