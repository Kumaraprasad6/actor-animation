import SwiftUI
import ReplayKit

struct PatternDetailView: View {
    let pattern: AnimationPattern
    @StateObject private var viewModel: PatternDetailViewModel
    @StateObject private var favoritesStore = FavoritesStore.shared
    @StateObject private var videoExporter = VideoExportManager()

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
                HStack(spacing: 4) {
                    recordButton
                    Button {
                        HapticsManager.shared.impact(for: .tap)
                        withAnimation(AnimationCurves.springBouncy) {
                            favoritesStore.toggle(pattern.id)
                        }
                    } label: {
                        Image(systemName: favoritesStore.isFavorite(pattern.id) ? "heart.fill" : "heart")
                            .foregroundStyle(favoritesStore.isFavorite(pattern.id) ? .red : AppColors.primaryText)
                    }
                    Button {
                        HapticsManager.shared.selection()
                        viewModel.resetControls()
                    } label: {
                        Image(systemName: "arrow.counterclockwise")
                    }
                }
            }
        }
        .overlay(alignment: .top) {
            if videoExporter.isRecording {
                recordingBanner
            }
        }
        .overlay {
            if videoExporter.isProcessing {
                processingOverlay
            }
        }
        .alert("Recording Saved", isPresented: completedBinding) {
            Button("OK") { videoExporter.reset() }
        } message: {
            Text("Your recording has been saved or shared from the preview screen. Check the Photos app if you saved it.")
        }
        .alert("Recording Error", isPresented: errorBinding) {
            Button("OK") { videoExporter.reset() }
        } message: {
            Text(videoExporter.errorMessage ?? "An unknown error occurred.")
        }
    }

    private var recordButton: some View {
        Button {
            HapticsManager.shared.impact(for: .tap)
            if videoExporter.isRecording {
                videoExporter.stopRecording()
            } else {
                videoExporter.startRecording()
            }
        } label: {
            if videoExporter.isProcessing {
                ProgressView()
                    .frame(width: 20, height: 20)
            } else {
                Image(systemName: videoExporter.isRecording ? "stop.circle.fill" : "record.circle")
                    .foregroundStyle(videoExporter.isRecording ? .red : AppColors.primaryText)
            }
        }
    }

    private var recordingBanner: some View {
        HStack(spacing: 8) {
            Circle()
                .fill(.red)
                .frame(width: 8, height: 8)
                .opacity(0.8)
                .scaleEffect(videoExporter.isRecording ? 1.3 : 0.7)
                .animation(
                    .easeInOut(duration: 0.8).repeatForever(autoreverses: true),
                    value: videoExporter.isRecording
                )
            Text("Recording…")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.white)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 8)
        .background(.red.opacity(0.9))
        .clipShape(Capsule())
        .padding(.top, 4)
        .transition(.move(edge: .top).combined(with: .opacity))
    }

    private var processingOverlay: some View {
        VStack(spacing: 16) {
            ProgressView()
                .scaleEffect(1.5)
            Text("Processing recording…")
                .font(.subheadline.weight(.medium))
                .foregroundStyle(AppColors.primaryText)
        }
        .padding(32)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .transition(.opacity)
    }

    private var completedBinding: Binding<Bool> {
        Binding(
            get: { videoExporter.state == .completed },
            set: { if !$0 { videoExporter.reset() } }
        )
    }

    private var errorBinding: Binding<Bool> {
        Binding(
            get: {
                if case .failed = videoExporter.state { return true }
                return false
            },
            set: { if !$0 { videoExporter.reset() } }
        )
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
