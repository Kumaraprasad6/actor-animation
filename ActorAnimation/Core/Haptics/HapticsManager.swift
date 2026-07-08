import UIKit

@MainActor
final class HapticsManager {
    static let shared = HapticsManager()

    private var isEnabled: Bool = true

    private init() {}

    func setEnabled(_ enabled: Bool) {
        isEnabled = enabled
    }

    func impact(for inputType: AnimationInput) {
        guard isEnabled else { return }
        let style: UIImpactFeedbackGenerator.FeedbackStyle
        switch inputType {
        case .tap:
            style = .light
        case .slider:
            style = .soft
        case .toggle:
            style = .medium
        case .drag:
            style = .medium
        case .pinch:
            style = .heavy
        case .swipe:
            style = .rigid
        }
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }

    func selection() {
        guard isEnabled else { return }
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
    }

    func success() {
        guard isEnabled else { return }
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }

    func warning() {
        guard isEnabled else { return }
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.warning)
    }
}