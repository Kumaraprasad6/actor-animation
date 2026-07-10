//
//  ActorAnimationApp.swift
//  ActorAnimation
//
//  Created by T0240U6 on 08/07/26.
//

import SwiftUI

@main
struct ActorAnimationApp: App {
    @StateObject private var settings = SettingsStore.shared

    var body: some Scene {
        WindowGroup {
            if settings.hasCompletedOnboarding {
                GalleryView()
                    .preferredColorScheme(settings.colorScheme.swiftUIColorScheme)
            } else {
                OnboardingView()
                    .preferredColorScheme(settings.colorScheme.swiftUIColorScheme)
            }
        }
        .environmentObject(settings)
    }
}

extension AppColorScheme {
    var swiftUIColorScheme: ColorScheme? {
        switch self {
        case .system: nil
        case .light: .light
        case .dark: .dark
        }
    }
}
