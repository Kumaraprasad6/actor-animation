import SwiftUI

struct FireSmokeParticlesPattern: View {
    let toggleValue: Bool
    @State private var particles: [FireParticle] = []
    @State private var timer: Timer?

    var body: some View {
        Canvas { context, size in
            for particle in particles {
                if particle.opacity > 0 {
                    let radius = particle.size
                    let rect = CGRect(x: particle.x - radius, y: particle.y - radius, width: radius * 2, height: radius * 2)
                    context.opacity = particle.opacity
                    context.fill(
                        Circle().path(in: rect),
                        with: .color(particle.color)
                    )
                }
            }
        }
        .frame(width: 240, height: 240)
        .onChange(of: toggleValue) { _, isOn in
            if isOn {
                startFire()
            } else {
                stopFire()
            }
        }
        .onAppear {
            if toggleValue { startFire() }
        }
        .onDisappear { stopFire() }
    }

    private func startFire() {
        stopFire()
        timer = Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { _ in
            spawnParticles()
            updateParticles()
        }
    }

    private func stopFire() {
        timer?.invalidate()
        timer = nil
        particles.removeAll()
    }

    private func spawnParticles() {
        let isFire = Bool.random()
        let count = 3
        for _ in 0..<count {
            let particle = FireParticle(
                x: CGFloat.random(in: 90...150),
                y: 200,
                vx: CGFloat.random(in: -10...10),
                vy: CGFloat.random(in: -60...(-30)),
                size: isFire ? CGFloat.random(in: 10...18) : CGFloat.random(in: 8...14),
                color: isFire
                    ? [Color(red: 0.9, green: 0.4, blue: 0.1), Color(red: 0.95, green: 0.6, blue: 0.2), Color(red: 1.0, green: 0.3, blue: 0.1)].randomElement()!
                    : [Color(white: 0.6, opacity: 0.5), Color(white: 0.7, opacity: 0.4)].randomElement()!,
                opacity: 1.0
            )
            particles.append(particle)
        }
        if particles.count > 80 {
            particles.removeFirst(particles.count - 80)
        }
    }

    private func updateParticles() {
        particles = particles.compactMap { p in
            var np = p
            np.x += np.vx * 0.03
            np.y += np.vy * 0.03
            np.size *= 1.01
            np.opacity -= 0.025
            return np.opacity > 0 ? np : nil
        }
    }
}

private struct FireParticle {
    var x: CGFloat
    var y: CGFloat
    var vx: CGFloat
    var vy: CGFloat
    var size: CGFloat
    var color: Color
    var opacity: Double
}

#Preview {
    FireSmokeParticlesPattern(toggleValue: true)
}