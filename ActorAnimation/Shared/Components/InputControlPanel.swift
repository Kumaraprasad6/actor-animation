import SwiftUI

struct InputControlPanel: View {
    let inputType: AnimationInput

    @Binding var tapTrigger: Int
    @Binding var sliderValue: Double
    @Binding var toggleValue: Bool
    @Binding var dragOffset: CGSize
    @Binding var pinchScale: CGFloat
    @Binding var swipeDirection: SwipeDirection

    enum SwipeDirection: Equatable {
        case none, left, right
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("CONTROLS")
                .font(AppTypography.caption())
                .foregroundStyle(AppColors.secondaryText)
                .padding(.horizontal)

            Group {
                switch inputType {
                case .tap:
                    Button {
                        tapTrigger += 1
                    } label: {
                        Label("Tap to Trigger", systemImage: "hand.tap.fill")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)

                case .slider:
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Value: \(String(format: "%.2f", sliderValue))")
                            .font(AppTypography.mono())
                        Slider(value: $sliderValue, in: 0...1)
                    }

                case .toggle:
                    Toggle(isOn: $toggleValue) {
                        Label("Toggle State", systemImage: "switch.2")
                    }
                    .toggleStyle(.switch)
                    .tint(AppColors.accent)

                case .drag, .pinch:
                    VStack(spacing: 12) {
                        if inputType == .drag {
                            Label("Drag the object on the canvas", systemImage: "hand.draw.fill")
                        } else {
                            Label("Pinch to zoom the object on the canvas", systemImage: "hand.pinch.fill")
                        }
                        Button("Reset") {
                            withAnimation(AnimationCurves.springBouncy) {
                                dragOffset = .zero
                                pinchScale = 1.0
                            }
                        }
                        .buttonStyle(.bordered)
                    }

                case .swipe:
                    Label("Swipe the object left or right", systemImage: "arrow.left.and.right")
                }
            }
            .padding(.horizontal)
        }
    }
}