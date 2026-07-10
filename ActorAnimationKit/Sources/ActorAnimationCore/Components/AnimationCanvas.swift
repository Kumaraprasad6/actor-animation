import SwiftUI

public struct AnimationCanvas<Content: View>: View {
    let content: Content

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(AppColors.card)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .strokeBorder(AppColors.separator.opacity(0.5), lineWidth: 1)
                )
            content
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .frame(minHeight: 280)
        .padding(.horizontal)
    }
}

#Preview {
    AnimationCanvas {
        Image(systemName: "circle")
            .font(.system(size: 60))
            .foregroundStyle(AppColors.accent)
    }
}
