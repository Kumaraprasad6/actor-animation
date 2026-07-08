import Foundation
import SwiftUI
import Combine

@MainActor
final class GalleryViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var selectedCategory: AnimationCategory?
    @Published var showFavoritesOnly: Bool = false
    @Published var favoritesStore: FavoritesStore

    init(favoritesStore: FavoritesStore = .shared) {
        self.favoritesStore = favoritesStore
    }

    var filteredPatterns: [AnimationPattern] {
        var results = PatternCatalog.filter(searchText: searchText, category: selectedCategory)
        if showFavoritesOnly {
            results = results.filter { favoritesStore.isFavorite($0.id) }
        }
        return results
    }

    var categories: [AnimationCategory] {
        AnimationCategory.allCases.filter { category in
            PatternCatalog.patterns.contains { $0.category == category }
        }
    }

    func selectCategory(_ category: AnimationCategory?) {
        selectedCategory = (selectedCategory == category) ? nil : category
    }

    func toggleFavoritesFilter() {
        showFavoritesOnly.toggle()
    }
}