// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "ActorAnimationKit",
    platforms: [.iOS(.v17)],
    products: [
        .library(name: "ActorAnimationCore", targets: ["ActorAnimationCore"]),
        .library(name: "ActorAnimationPatterns", targets: ["ActorAnimationPatterns"]),
    ],
    targets: [
        .target(
            name: "ActorAnimationCore",
            dependencies: []
        ),
        .target(
            name: "ActorAnimationPatterns",
            dependencies: ["ActorAnimationCore"]
        ),
    ]
)
