import SwiftUI

struct ParticleBurstPattern: View {
    let tapTrigger: Int
    @State private var particles: [Particle] = []

    var body: some View {
        Canvas { context, size in
            for particle in particles {
                if particle.opacity > 0 {
                    context.opacity = particle.opacity
                    context.fill(
                        Circle()
                            .path(in: CGRect(x: particle.x, y: particle.y, width: particle.size, height: particle.size)),
                        with: .color(particle.color)
                    )
                }
            }
        }
        .frame(width: 240, height: 240)
        .onChange(of: tapTrigger) { _, _ in
            burst()
        }
        .onTapGesture { burst() }
        .onAppear {
            burst()
        }
    }

    private func burst() {
        let count = 24
        let newParticles = (0..<count).map { i in
            Particle(
                x: 120,
                y: 120,
                vx: CGFloat.random(in: -180...180),
                vy: CGFloat.random(in: -180...180),
                size: CGFloat.random(in: 8...16),
                color: [AppColors.accent, .green, .yellow, .pink, .teal].randomElement()!,
                opacity: 1.0,
                scale: 1.0
            )
        }
        particles = newParticles
        animateParticles()
    }

    private func animateParticles() {
        for step in 0..<40 {
            let delay = Double(step) / 40.0
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                particles = particles.map { p in
                    var np = p
                    np.x += np.vx * 0.04
                    np.y += np.vy * 0.04
                    np.vy += 80 * 0.04
                    np.opacity = max(0, np.opacity - 0.04)
                    return np
                }
            }
        }
    }
}

private struct Particle {
    var x: CGFloat
    var y: CGFloat
    var vx: CGFloat
    var vy: CGFloat
    var size: CGFloat
    var color: Color
    var opacity: Double
    var scale: CGFloat
}

#Preview {
    ParticleBurstPattern(tapTrigger: 0)
}