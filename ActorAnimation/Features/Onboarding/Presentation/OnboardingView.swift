import SwiftUI
import ActorAnimationCore

struct OnboardingView: View {
    @StateObject private var settings = SettingsStore.shared
    @State private var currentPage = 0

    private let pages: [OnboardingPage] = [
        OnboardingPage(
            icon: "sparkles",
            iconColor: .accentColor,
            title: "Welcome to ActorAnimation",
            subtitle: "Explore 27+ interactive SwiftUI animation patterns across 8 categories."
        ),
        OnboardingPage(
            icon: "square.grid.2x2.fill",
            iconColor: .blue,
            title: "Browse by Category",
            subtitle: "Filter patterns by Transform, Transition, Gesture, Shape, Timer, Gradient, Effects, and 3D."
        ),
        OnboardingPage(
            icon: "hand.tap.fill",
            iconColor: .orange,
            title: "Interactive Controls",
            subtitle: "Each pattern responds to tap, drag, pinch, swipe, slider, or toggle inputs."
        ),
        OnboardingPage(
            icon: "heart.fill",
            iconColor: .red,
            title: "Save & Share",
            subtitle: "Favorite patterns for quick access, record animations as video, and customize settings."
        )
    ]

    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $currentPage) {
                ForEach(pages.indices, id: \.self) { index in
                    OnboardingPageView(page: pages[index])
                        .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(maxHeight: .infinity)

            VStack(spacing: 20) {
                pageIndicator

                Button {
                    HapticsManager.shared.success()
                    if currentPage < pages.count - 1 {
                        withAnimation(AnimationCurves.springSmooth) {
                            currentPage += 1
                        }
                    } else {
                        settings.hasCompletedOnboarding = true
                    }
                } label: {
                    Text(currentPage < pages.count - 1 ? "Next" : "Get Started")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(AppColors.accent, in: RoundedRectangle(cornerRadius: 14))
                }

                if currentPage < pages.count - 1 {
                    Button {
                        HapticsManager.shared.selection()
                        settings.hasCompletedOnboarding = true
                    } label: {
                        Text("Skip")
                            .font(.subheadline)
                            .foregroundStyle(AppColors.secondaryText)
                    }
                }
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 32)
            .padding(.top, 16)
        }
        .background(AppColors.background)
    }

    private var pageIndicator: some View {
        HStack(spacing: 8) {
            ForEach(pages.indices, id: \.self) { index in
                Circle()
                    .fill(index == currentPage ? AppColors.accent : AppColors.separator)
                    .frame(width: 8, height: 8)
                    .animation(AnimationCurves.springSmooth, value: currentPage)
            }
        }
    }
}

private struct OnboardingPage {
    let icon: String
    let iconColor: Color
    let title: String
    let subtitle: String
}

private struct OnboardingPageView: View {
    let page: OnboardingPage

    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            Image(systemName: page.icon)
                .font(.system(size: 72, weight: .light))
                .foregroundStyle(page.iconColor)
                .frame(width: 120, height: 120)
                .background(page.iconColor.opacity(0.12), in: Circle())

            VStack(spacing: 12) {
                Text(page.title)
                    .font(.title2.weight(.semibold))
                    .foregroundStyle(AppColors.primaryText)
                    .multilineTextAlignment(.center)

                Text(page.subtitle)
                    .font(.body)
                    .foregroundStyle(AppColors.secondaryText)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
            }

            Spacer()
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    OnboardingView()
}
