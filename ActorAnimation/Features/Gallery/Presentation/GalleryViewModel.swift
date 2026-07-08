import Foundation
import SwiftUI
import Combine

@MainActor
final class GalleryViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var selectedCategory: AnimationCategory?

    var filteredPatterns: [AnimationPattern] {
        PatternCatalog.filter(searchText: searchText, category: selectedCategory)
    }

    var categories: [AnimationCategory] {
        AnimationCategory.allCases.filter { category in
            PatternCatalog.patterns.contains { $0.category == category }
        }
    }

    func selectCategory(_ category: AnimationCategory?) {
        selectedCategory = (selectedCategory == category) ? nil : category
    }
}