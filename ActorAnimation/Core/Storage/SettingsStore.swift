import Foundation
import Combine
import SwiftUI
import ActorAnimationCore

@MainActor
final class SettingsStore: ObservableObject {
    static let shared = SettingsStore()

    @Published var colorScheme: AppColorScheme {
        didSet { defaults.set(colorScheme.rawValue, forKey: Keys.colorScheme) }
    }
    @Published var defaultDuration: Double {
        didSet { defaults.set(defaultDuration, forKey: Keys.defaultDuration) }
    }
    @Published var hapticsEnabled: Bool {
        didSet {
            defaults.set(hapticsEnabled, forKey: Keys.hapticsEnabled)
            HapticsManager.shared.setEnabled(hapticsEnabled)
        }
    }
    @Published var hasCompletedOnboarding: Bool {
        didSet { defaults.set(hasCompletedOnboarding, forKey: Keys.hasCompletedOnboarding) }
    }

    private let defaults = UserDefaults.standard

    private enum Keys {
        static let colorScheme = "settings.colorScheme"
        static let defaultDuration = "settings.defaultDuration"
        static let hapticsEnabled = "settings.hapticsEnabled"
        static let hasCompletedOnboarding = "settings.hasCompletedOnboarding"
    }

    private init() {
        colorScheme = AppColorScheme(rawValue: defaults.string(forKey: Keys.colorScheme) ?? "system") ?? .system
        defaultDuration = defaults.object(forKey: Keys.defaultDuration) as? Double ?? 0.4
        hapticsEnabled = defaults.object(forKey: Keys.hapticsEnabled) as? Bool ?? true
        hasCompletedOnboarding = defaults.bool(forKey: Keys.hasCompletedOnboarding)
        HapticsManager.shared.setEnabled(hapticsEnabled)
    }
}

enum AppColorScheme: String, CaseIterable, Identifiable {
    case system
    case light
    case dark

    var id: String { rawValue }

    var title: String {
        switch self {
        case .system: "System"
        case .light: "Light"
        case .dark: "Dark"
        }
    }

    var icon: String {
        switch self {
        case .system: "circle.lefthalf.filled"
        case .light: "sun.max.fill"
        case .dark: "moon.stars.fill"
        }
    }
}