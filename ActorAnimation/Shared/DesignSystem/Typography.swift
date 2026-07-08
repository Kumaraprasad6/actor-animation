import SwiftUI

enum AppTypography {
    static func title() -> Font { .title2.weight(.semibold) }
    static func headline() -> Font { .headline.weight(.medium) }
    static func body() -> Font { .body }
    static func caption() -> Font { .caption.weight(.regular) }
    static func mono(_ size: CGFloat = 13) -> Font { .system(size: size, weight: .regular, design: .monospaced) }
}