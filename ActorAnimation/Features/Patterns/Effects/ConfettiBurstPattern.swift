import SwiftUI

struct ConfettiBurstPattern: View {
    let tapTrigger: Int
    @State private var particles: [Confetti] = []
    @State private var burstID = UUID()

    var body: some View {
        ZStack {
            ForEach(particles) { p in
                Rectangle()
                    .fill(p.color)
                    .frame(width: p.size, height: p.size * 0.4)
                    .cornerRadius(2)
                    .position(x: p.x, y: p.y)
                    .rotationEffect(.degrees(p.rotation))
                    .opacity(p.opacity)
            }
        }
        .frame(width: 240, height: 240)
        .contentShape(Rectangle())
        .onChange(of: tapTrigger) { _, _ in
            burst()
        }
        .onTapGesture { burst() }
        .onAppear { burst() }
    }

    private func burst() {
        burstID = UUID()
        let count = 30
        let colors: [Color] = [.red, .orange, .yellow, .green, .blue, .purple, .pink, .teal]

        particles = (0..<count).map { i in
            let angle = Double(i) / Double(count) * 2 * .pi
            let velocity = CGFloat.random(in: 80...160)
            return Confetti(
                x: 120,
                y: 120,
                vx: cos(angle) * velocity,
                vy: sin(angle) * velocity - 40,
                size: CGFloat.random(in: 8...14),
                color: colors.randomElement()!,
                rotation: Double.random(in: 0...360),
                rotationSpeed: Double.random(in: -360...360),
                opacity: 1.0
            )
        }

        for step in 0..<50 {
            let delay = Double(step) / 60.0
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                particles = particles.map { p in
                    var np = p
                    np.x += np.vx * 0.03
                    np.y += np.vy * 0.03
                    np.vy += 120 * 0.03
                    np.rotation += np.rotationSpeed * 0.03
                    np.opacity = max(0, np.opacity - 0.025)
                    return np
                }
            }
        }
    }
}

private struct Confetti: Identifiable {
    let id = UUID()
    var x: CGFloat
    var y: CGFloat
    var vx: CGFloat
    var vy: CGFloat
    var size: CGFloat
    var color: Color
    var rotation: Double
    var rotationSpeed: Double
    var opacity: Double
}

#Preview {
    ConfettiBurstPattern(tapTrigger: 0)
}