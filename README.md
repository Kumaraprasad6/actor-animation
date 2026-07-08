# ActorAnimation

An interactive SwiftUI animation pattern showcase for iOS. Browse, search, and interact with 15+ animation patterns across 5 categories — each with contextual input controls (tap, drag, pinch, swipe, slider, toggle).

## Patterns

| Category | Patterns |
|----------|----------|
| Transform | Scale Pulse, Rotate, Flip Card |
| Transition | Slide Transition, Scale + Fade, Matched Geometry |
| Gesture | Drag to Dismiss, Pinch Zoom, Swipe Card |
| Shape | Morphing Shape, Progress Arc, Particle Burst |
| Timer | Breathing, Staggered List, Marquee |

## Architecture

MVVM + Clean Architecture using SwiftUI and `NavigationStack`.

```
ActorAnimation/
├── App/                  Entry point + root navigation
├── Core/                 Domain models, enums, utilities (no SwiftUI)
│   ├── Models/           AnimationPattern, AnimationCategory, AnimationInput
│   └── Utilities/        AnimationCurves (shared timing presets)
├── Features/
│   ├── Gallery/          Listing + search + category filter
│   │   ├── Data/         PatternCatalog (static registry)
│   │   └── Presentation/ View, ViewModel, Coordinator
│   ├── PatternDetail/    Single pattern player + input controls
│   │   └── Presentation/ View, ViewModel
│   └── Patterns/         Individual animation view components
│       ├── Transform/    ScalePulse, Rotate, FlipCard
│       ├── Transition/   Slide, ScaleFade, MatchedGeometry
│       ├── Gesture/      DragDismiss, PinchZoom, SwipeCard
│       ├── Shape/        MorphingShape, ProgressArc, ParticleBurst
│       └── Timer/        Breathing, StaggeredList, Marquee
└── Shared/
    ├── Components/        Reusable InputControlPanel, AnimationCanvas
    └── DesignSystem/     Colors, Typography
```

## Adding a New Pattern

1. Create a new `View` under `Features/Patterns/<Category>/`.
2. Register the `AnimationPattern` entry in `PatternCatalog.patterns`.
3. Add a `case` to the `switch` in `PatternDetailView.patternView`.

## Requirements

- iOS 26.5+
- Xcode 26.5+
- Swift 5

## Build

```sh
xcodebuild -scheme ActorAnimation -destination 'platform=iOS Simulator,name=iPhone 17 Pro' build
```

## Test

```sh
xcodebuild test -scheme ActorAnimation -destination 'platform=iOS Simulator,name=iPhone 17 Pro' -only-testing:ActorAnimationTests
```

## Branching

- `main` — protected, MVP release
- `develop` — integration branch for feature work
- `feature/*` — individual feature branches merged into `develop`

## License

All rights reserved.