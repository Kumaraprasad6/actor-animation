import Foundation

struct AnimationPattern: Identifiable, Hashable {
    let id: String
    let title: String
    let subtitle: String
    let category: AnimationCategory
    let inputType: AnimationInput
    let patternKey: String

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: AnimationPattern, rhs: AnimationPattern) -> Bool {
        lhs.id == rhs.id
    }
}