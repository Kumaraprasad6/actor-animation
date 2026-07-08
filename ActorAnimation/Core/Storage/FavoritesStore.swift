import Foundation
import Combine
import SwiftUI

@MainActor
final class FavoritesStore: ObservableObject {
    static let shared = FavoritesStore()

    @Published private(set) var favoriteIDs: Set<String> = []

    private let defaults = UserDefaults.standard
    private let key = "favoritePatternIDs"

    private init() {
        load()
    }

    func isFavorite(_ patternID: String) -> Bool {
        favoriteIDs.contains(patternID)
    }

    func toggle(_ patternID: String) {
        if favoriteIDs.contains(patternID) {
            favoriteIDs.remove(patternID)
        } else {
            favoriteIDs.insert(patternID)
        }
        save()
    }

    func add(_ patternID: String) {
        favoriteIDs.insert(patternID)
        save()
    }

    func remove(_ patternID: String) {
        favoriteIDs.remove(patternID)
        save()
    }

    func clear() {
        favoriteIDs.removeAll()
        save()
    }

    private func load() {
        let ids = defaults.stringArray(forKey: key) ?? []
        favoriteIDs = Set(ids)
    }

    private func save() {
        defaults.set(Array(favoriteIDs), forKey: key)
    }
}