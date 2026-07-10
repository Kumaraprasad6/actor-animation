import SwiftUI

public enum AppTypography {
    public static func title() -> Font { .title2.weight(.semibold) }
    public static func headline() -> Font { .headline.weight(.medium) }
    public static func body() -> Font { .body }
    public static func caption() -> Font { .caption.weight(.regular) }
    public static func mono(_ size: CGFloat = 13) -> Font { .system(size: size, weight: .regular, design: .monospaced) }
}
