import Foundation

public struct AnimationPattern: Identifiable, Hashable, Sendable {
    public let id: String
    public let title: String
    public let subtitle: String
    public let category: AnimationCategory
    public let inputType: AnimationInput
    public let patternKey: String

    public init(id: String, title: String, subtitle: String, category: AnimationCategory, inputType: AnimationInput, patternKey: String) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.category = category
        self.inputType = inputType
        self.patternKey = patternKey
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    public static func == (lhs: AnimationPattern, rhs: AnimationPattern) -> Bool {
        lhs.id == rhs.id
    }
}
