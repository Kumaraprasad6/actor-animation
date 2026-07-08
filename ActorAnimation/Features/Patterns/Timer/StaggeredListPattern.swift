import SwiftUI

struct StaggeredListPattern: View {
    let tapTrigger: Int
    @State private var visibleIndices: Set<Int> = []

    private let items: [(String, String, Color)] = [
        ("bell.fill", "Notification", .blue),
        ("envelope.fill", "Messages", .green),
        ("heart.fill", "Favorites", .pink),
        ("star.fill", "Reviews", .yellow),
        ("bookmark.fill", "Saved", .teal),
    ]

    var body: some View {
        VStack(spacing: 12) {
            ForEach(items.indices, id: \.self) { index in
                HStack(spacing: 14) {
                    Image(systemName: items[index].0)
                        .font(.system(size: 22))
                        .foregroundStyle(items[index].2)
                        .frame(width: 36, height: 36)
                    Text(items[index].1)
                        .font(AppTypography.body())
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.caption)
                        .foregroundStyle(AppColors.secondaryText)
                }
                .padding(14)
                .background(AppColors.secondaryBackground)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .opacity(visibleIndices.contains(index) ? 1 : 0)
                .offset(y: visibleIndices.contains(index) ? 0 : 24)
                .animation(
                    .easeOut(duration: 0.5).delay(Double(index) * 0.1),
                    value: visibleIndices
                )
            }
        }
        .frame(width: 240)
        .onChange(of: tapTrigger) { _, _ in
            animateIn()
        }
        .onAppear {
            animateIn()
        }
    }

    private func animateIn() {
        visibleIndices.removeAll()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            for index in items.indices {
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.1) {
                    visibleIndices.insert(index)
                }
            }
        }
    }
}

#Preview {
    StaggeredListPattern(tapTrigger: 0)
}