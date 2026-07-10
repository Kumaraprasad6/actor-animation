import UIKit

@MainActor
public final class HapticsManager {
    public static let shared = HapticsManager()

    private var isEnabled: Bool = true

    private init() {}

    public func setEnabled(_ enabled: Bool) {
        isEnabled = enabled
    }

    public func impact(for inputType: AnimationInput) {
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

    public func selection() {
        guard isEnabled else { return }
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
    }

    public func success() {
        guard isEnabled else { return }
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }

    public func warning() {
        guard isEnabled else { return }
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.warning)
    }
}
