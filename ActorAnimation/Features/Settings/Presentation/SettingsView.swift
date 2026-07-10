import SwiftUI
import ActorAnimationCore

struct SettingsView: View {
    @StateObject private var settings = SettingsStore.shared

    var body: some View {
        Form {
            Section {
                Picker("Appearance", selection: $settings.colorScheme) {
                    ForEach(AppColorScheme.allCases) { scheme in
                        Label(scheme.title, systemImage: scheme.icon).tag(scheme)
                    }
                }
            } header: {
                Text("Theme")
            }

            Section {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Duration: \(String(format: "%.2f", settings.defaultDuration))s")
                        .font(AppTypography.mono())
                    Slider(value: $settings.defaultDuration, in: 0.1...2.0, step: 0.05)
                }
            } header: {
                Text("Animation")
            } footer: {
                Text("Default duration for animations that use standard timing.")
            }

            Section {
                Toggle(isOn: $settings.hapticsEnabled) {
                    Label("Haptic Feedback", systemImage: "hand.tap.fill")
                }
            } header: {
                Text("Feedback")
            } footer: {
                Text("Enable or disable haptic feedback for all interactions.")
            }

            Section {
                LabeledContent("Pattern Count", value: "\(PatternCatalog.patterns.count)")
                LabeledContent("Version", value: "1.0.0")
            } header: {
                Text("About")
            }

            Section {
                Button {
                    HapticsManager.shared.selection()
                    settings.hasCompletedOnboarding = false
                } label: {
                    Label("Replay Onboarding", systemImage: "arrow.clockwise")
                }
            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        SettingsView()
    }
}