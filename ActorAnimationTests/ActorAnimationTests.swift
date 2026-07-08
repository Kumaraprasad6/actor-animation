import XCTest
@testable import ActorAnimation

@MainActor
final class ActorAnimationTests: XCTestCase {

    func testPatternCatalogContains19Patterns() {
        XCTAssertEqual(PatternCatalog.patterns.count, 19)
    }

    func testPatternCatalogIDsAreUnique() {
        let ids = PatternCatalog.patterns.map(\.id)
        XCTAssertEqual(Set(ids).count, ids.count)
    }

    func testPatternLookupByID() {
        let pattern = PatternCatalog.pattern(forID: "scale-pulse")
        XCTAssertNotNil(pattern)
        XCTAssertEqual(pattern?.title, "Scale Pulse")
        XCTAssertEqual(pattern?.category, .transform)
        XCTAssertEqual(pattern?.inputType, .tap)
    }

    func testPatternLookupNonexistentReturnsNil() {
        XCTAssertNil(PatternCatalog.pattern(forID: "does-not-exist"))
    }

    func testFilterBySearchText() {
        let results = PatternCatalog.filter(searchText: "drag", category: nil)
        XCTAssertTrue(results.contains { $0.id == "drag-dismiss" })
    }

    func testFilterByCategory() {
        let results = PatternCatalog.filter(searchText: "", category: .shape)
        XCTAssertEqual(results.count, 3)
        XCTAssertTrue(results.allSatisfy { $0.category == .shape })
    }

    func testFilterByBothSearchAndCategory() {
        let results = PatternCatalog.filter(searchText: "arc", category: .shape)
        XCTAssertEqual(results.count, 1)
        XCTAssertEqual(results.first?.id, "progress-arc")
    }

    func testFilterGradientCategory() {
        let results = PatternCatalog.filter(searchText: "", category: .gradient)
        XCTAssertEqual(results.count, 4)
        XCTAssertTrue(results.allSatisfy { $0.category == .gradient })
    }

    func testGradientPatternLookup() {
        let mesh = PatternCatalog.pattern(forID: "gradient-mesh")
        XCTAssertNotNil(mesh)
        XCTAssertEqual(mesh?.category, .gradient)
        XCTAssertEqual(mesh?.inputType, .slider)

        let hue = PatternCatalog.pattern(forID: "hue-rainbow")
        XCTAssertNotNil(hue)
        XCTAssertEqual(hue?.inputType, .slider)

        let conic = PatternCatalog.pattern(forID: "conic-rotation")
        XCTAssertNotNil(conic)
        XCTAssertEqual(conic?.inputType, .slider)

        let color = PatternCatalog.pattern(forID: "color-transition")
        XCTAssertNotNil(color)
        XCTAssertEqual(color?.inputType, .toggle)
    }

    func testEmptySearchReturnsAll() {
        let results = PatternCatalog.filter(searchText: "", category: nil)
        XCTAssertEqual(results.count, 19)
    }

    func testAnimationCategoryHasUniqueTitles() {
        let titles = AnimationCategory.allCases.map(\.title)
        XCTAssertEqual(Set(titles).count, titles.count)
    }

    func testAnimationCategoryHasUniqueSystemImageNames() {
        let names = AnimationCategory.allCases.map(\.systemImageName)
        XCTAssertEqual(Set(names).count, names.count)
    }

    func testAnimationInputHasUniqueTitles() {
        let titles = AnimationInput.allCases.map(\.title)
        XCTAssertEqual(Set(titles).count, titles.count)
    }

    func testGalleryViewModelInitialSearchText() {
        let vm = GalleryViewModel()
        XCTAssertTrue(vm.searchText.isEmpty)
        XCTAssertNil(vm.selectedCategory)
        XCTAssertEqual(vm.filteredPatterns.count, 19)
    }

    func testGalleryViewModelSelectCategory() {
        let vm = GalleryViewModel()
        vm.selectCategory(.transform)
        XCTAssertEqual(vm.selectedCategory, .transform)
        XCTAssertEqual(vm.filteredPatterns.count, 3)
    }

    func testGalleryViewModelSelectGradientCategory() {
        let vm = GalleryViewModel()
        vm.selectCategory(.gradient)
        XCTAssertEqual(vm.selectedCategory, .gradient)
        XCTAssertEqual(vm.filteredPatterns.count, 4)
    }

    func testGalleryViewModelToggleOffCategory() {
        let vm = GalleryViewModel()
        vm.selectCategory(.shape)
        vm.selectCategory(.shape)
        XCTAssertNil(vm.selectedCategory)
        XCTAssertEqual(vm.filteredPatterns.count, 19)
    }

    func testGalleryViewModelSearchTextFilters() {
        let vm = GalleryViewModel()
        vm.searchText = "card"
        XCTAssertEqual(vm.filteredPatterns.count, 2)
    }

    func testGalleryViewModelSearchGradient() {
        let vm = GalleryViewModel()
        vm.searchText = "gradient"
        XCTAssertEqual(vm.filteredPatterns.count, 1)
    }

    func testPatternDetailViewModelInitialDefaults() {
        let pattern = PatternCatalog.pattern(forID: "rotate")!
        let vm = PatternDetailViewModel(pattern: pattern)
        XCTAssertEqual(vm.tapTrigger, 0)
        XCTAssertEqual(vm.sliderValue, 0.5)
        XCTAssertFalse(vm.toggleValue)
        XCTAssertEqual(vm.pinchScale, 1.0)
    }

    func testPatternDetailViewModelResetControls() {
        let pattern = PatternCatalog.pattern(forID: "rotate")!
        let vm = PatternDetailViewModel(pattern: pattern)
        vm.tapTrigger = 5
        vm.sliderValue = 0.9
        vm.toggleValue = true
        vm.pinchScale = 2.0
        vm.resetControls()
        XCTAssertEqual(vm.tapTrigger, 0)
        XCTAssertEqual(vm.sliderValue, 0.5)
        XCTAssertFalse(vm.toggleValue)
        XCTAssertEqual(vm.pinchScale, 1.0)
    }

    func testPatternDetailViewModelStoresPattern() {
        let pattern = PatternCatalog.pattern(forID: "breathing")!
        let vm = PatternDetailViewModel(pattern: pattern)
        XCTAssertEqual(vm.pattern.id, "breathing")
    }
}