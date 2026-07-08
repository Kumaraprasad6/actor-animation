import Foundation

enum PatternCatalog {
    static let patterns: [AnimationPattern] = [
        .init(id: "scale-pulse", title: "Scale Pulse", subtitle: "Spring pulse on tap",
              category: .transform, inputType: .tap, patternKey: "scale-pulse"),
        .init(id: "rotate", title: "Rotate", subtitle: "Continuous rotation controlled by slider",
              category: .transform, inputType: .slider, patternKey: "rotate"),
        .init(id: "flip-card", title: "Flip Card", subtitle: "3D flip front/back",
              category: .transform, inputType: .tap, patternKey: "flip-card"),

        .init(id: "slide-transition", title: "Slide Transition", subtitle: "Move edge transition on toggle",
              category: .transition, inputType: .toggle, patternKey: "slide-transition"),
        .init(id: "scale-fade", title: "Scale + Fade", subtitle: "Asymmetric scale and opacity",
              category: .transition, inputType: .tap, patternKey: "scale-fade"),
        .init(id: "matched-geometry", title: "Matched Geometry", subtitle: "Shared element transition",
              category: .transition, inputType: .tap, patternKey: "matched-geometry"),

        .init(id: "drag-dismiss", title: "Drag to Dismiss", subtitle: "Spring-back on drag release",
              category: .gesture, inputType: .drag, patternKey: "drag-dismiss"),
        .init(id: "pinch-zoom", title: "Pinch Zoom", subtitle: "MagnificationGesture scale",
              category: .gesture, inputType: .pinch, patternKey: "pinch-zoom"),
        .init(id: "swipe-card", title: "Swipe Card", subtitle: "Tinder-style swipe with rotation",
              category: .gesture, inputType: .swipe, patternKey: "swipe-card"),

        .init(id: "morphing-shape", title: "Morphing Shape", subtitle: "Path interpolation circle-star",
              category: .shape, inputType: .slider, patternKey: "morphing-shape"),
        .init(id: "progress-arc", title: "Progress Arc", subtitle: "Animated trim arc",
              category: .shape, inputType: .slider, patternKey: "progress-arc"),
        .init(id: "particle-burst", title: "Particle Burst", subtitle: "Canvas particle explosion",
              category: .shape, inputType: .tap, patternKey: "particle-burst"),

        .init(id: "breathing", title: "Breathing", subtitle: "Repeating easeInOut scale",
              category: .timer, inputType: .toggle, patternKey: "breathing"),
        .init(id: "staggered-list", title: "Staggered List", subtitle: "Items appear with staggered delay",
              category: .timer, inputType: .tap, patternKey: "staggered-list"),
        .init(id: "marquee", title: "Marquee", subtitle: "Continuous horizontal scroll",
              category: .timer, inputType: .toggle, patternKey: "marquee"),

        .init(id: "gradient-mesh", title: "Gradient Mesh", subtitle: "Animated multi-color mesh flow",
              category: .gradient, inputType: .slider, patternKey: "gradient-mesh"),
        .init(id: "hue-rainbow", title: "Hue Rainbow Flow", subtitle: "Rotating angular rainbow gradient",
              category: .gradient, inputType: .slider, patternKey: "hue-rainbow"),
        .init(id: "conic-rotation", title: "Conic Rotation", subtitle: "Spinning conic gradient",
              category: .gradient, inputType: .slider, patternKey: "conic-rotation"),
        .init(id: "color-transition", title: "Color Transition", subtitle: "Warm-to-cool gradient on toggle",
              category: .gradient, inputType: .toggle, patternKey: "color-transition"),
    ]

    static func pattern(forID id: String) -> AnimationPattern? {
        patterns.first { $0.id == id }
    }

    static func filter(searchText: String, category: AnimationCategory?) -> [AnimationPattern] {
        patterns.filter { pattern in
            let matchesSearch = searchText.isEmpty
                || pattern.title.localizedCaseInsensitiveContains(searchText)
                || pattern.subtitle.localizedCaseInsensitiveContains(searchText)
            let matchesCategory = category == nil || pattern.category == category
            return matchesSearch && matchesCategory
        }
    }
}