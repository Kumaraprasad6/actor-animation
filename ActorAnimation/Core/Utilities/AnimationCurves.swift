import SwiftUI

enum AnimationCurves {
    static let springBouncy = Animation.spring(response: 0.35, dampingFraction: 0.6, blendDuration: 0)
    static let springSmooth = Animation.spring(response: 0.5, dampingFraction: 0.8, blendDuration: 0)
    static let springSnappy = Animation.spring(response: 0.3, dampingFraction: 0.7, blendDuration: 0)
    static let easeQuick = Animation.easeInOut(duration: 0.25)
    static let easeStandard = Animation.easeInOut(duration: 0.4)
    static let easeSlow = Animation.easeInOut(duration: 0.8)
}