import SwiftUI

public enum AnimationCurves {
    public static let springBouncy = Animation.spring(response: 0.35, dampingFraction: 0.6, blendDuration: 0)
    public static let springSmooth = Animation.spring(response: 0.5, dampingFraction: 0.8, blendDuration: 0)
    public static let springSnappy = Animation.spring(response: 0.3, dampingFraction: 0.7, blendDuration: 0)
    public static let easeQuick = Animation.easeInOut(duration: 0.25)
    public static let easeStandard = Animation.easeInOut(duration: 0.4)
    public static let easeSlow = Animation.easeInOut(duration: 0.8)
}
