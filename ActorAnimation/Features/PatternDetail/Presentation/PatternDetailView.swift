import SwiftUI

struct PatternDetailView: View {
    let pattern: AnimationPattern
    @StateObject private var viewModel: PatternDetailViewModel

    init(pattern: AnimationPattern) {
        self.pattern = pattern
        _viewModel = StateObject(wrappedValue: PatternDetailViewModel(pattern: pattern))
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                headerSection
                patternCanvas
                controlsPanel
            }
            .padding(.vertical)
        }
        .background(AppColors.background)
        .navigationTitle(pattern.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    viewModel.resetControls()
                } label: {
                    Image(systemName: "arrow.counterclockwise")
                }
            }
        }
    }

    private var headerSection: some View {
        VStack(spacing: 8) {
            Image(systemName: pattern.category.systemImageName)
                .font(.system(size: 28))
                .foregroundStyle(pattern.category.color)
            Text(pattern.subtitle)
                .font(AppTypography.body())
                .foregroundStyle(AppColors.secondaryText)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 8)
    }

    private var patternCanvas: some View {
        AnimationCanvas {
            patternView
                .frame(maxWidth: .infinity, minHeight: 240)
        }
    }

    @ViewBuilder
    private var patternView: some View {
        switch pattern.id {
        case "scale-pulse":
            ScalePulsePattern(tapTrigger: viewModel.tapTrigger)
        case "rotate":
            RotatePattern(sliderValue: viewModel.sliderValue)
        case "flip-card":
            FlipCardPattern(tapTrigger: viewModel.tapTrigger)
        case "slide-transition":
            SlideTransitionPattern(toggleValue: viewModel.toggleValue)
        case "scale-fade":
            ScaleFadePattern(tapTrigger: viewModel.tapTrigger)
        case "matched-geometry":
            MatchedGeometryPattern(tapTrigger: viewModel.tapTrigger)
        case "drag-dismiss":
            DragDismissPattern(dragOffset: $viewModel.dragOffset)
        case "pinch-zoom":
            PinchZoomPattern(pinchScale: $viewModel.pinchScale)
        case "swipe-card":
            SwipeCardPattern(swipeDirection: $viewModel.swipeDirection)
        case "morphing-shape":
            MorphingShapePattern(sliderValue: viewModel.sliderValue)
        case "progress-arc":
            ProgressArcPattern(sliderValue: viewModel.sliderValue)
        case "particle-burst":
            ParticleBurstPattern(tapTrigger: viewModel.tapTrigger)
        case "breathing":
            BreathingPattern(toggleValue: viewModel.toggleValue)
        case "staggered-list":
            StaggeredListPattern(tapTrigger: viewModel.tapTrigger)
        case "marquee":
            MarqueePattern(toggleValue: viewModel.toggleValue)
        case "gradient-mesh":
            AnimatedGradientMeshPattern(sliderValue: viewModel.sliderValue)
        case "hue-rainbow":
            HueRainbowFlowPattern(sliderValue: viewModel.sliderValue)
        case "conic-rotation":
            ConicRotationGradientPattern(sliderValue: viewModel.sliderValue)
        case "color-transition":
            ColorTransitionGradientPattern(toggleValue: viewModel.toggleValue)
        case "confetti-burst":
            ConfettiBurstPattern(tapTrigger: viewModel.tapTrigger)
        case "loading-spinner":
            LoadingSpinnerPattern(toggleValue: viewModel.toggleValue)
        case "shimmer":
            ShimmerEffectPattern(toggleValue: viewModel.toggleValue)
        case "liquid-chrome":
            LiquidChromePattern(sliderValue: viewModel.sliderValue)
        case "fire-smoke":
            FireSmokeParticlesPattern(toggleValue: viewModel.toggleValue)
        case "cube-3d":
            Cube3DRotationPattern(sliderValue: viewModel.sliderValue)
        case "parallax-depth":
            ParallaxDepthPattern(sliderValue: viewModel.sliderValue)
        case "perspective-tilt":
            PerspectiveTiltPattern(dragOffset: $viewModel.dragOffset)
        default:
            Text("Not implemented")
                .foregroundStyle(AppColors.secondaryText)
        }
    }

    private var controlsPanel: some View {
        VStack(spacing: 0) {
            InputControlPanel(
                inputType: pattern.inputType,
                tapTrigger: $viewModel.tapTrigger,
                sliderValue: $viewModel.sliderValue,
                toggleValue: $viewModel.toggleValue,
                dragOffset: $viewModel.dragOffset,
                pinchScale: $viewModel.pinchScale,
                swipeDirection: $viewModel.swipeDirection
            )
        }
        .padding(.bottom)
    }
}
