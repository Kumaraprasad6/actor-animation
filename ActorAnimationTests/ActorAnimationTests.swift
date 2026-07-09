import XCTest
@testable import ActorAnimation

@MainActor
final class ActorAnimationTests: XCTestCase {

    func testPatternCatalogContains24Patterns() {
        XCTAssertEqual(PatternCatalog.patterns.count, 27)
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

    func testFilterEffectsCategory() {
        let results = PatternCatalog.filter(searchText: "", category: .effects)
        XCTAssertEqual(results.count, 5)
        XCTAssertTrue(results.allSatisfy { $0.category == .effects })
    }

        func testEffectsPatternLookup() {
            let confetti = PatternCatalog.pattern(forID: "confetti-burst")
            XCTAssertNotNil(confetti)
            XCTAssertEqual(confetti?.category, .effects)
            XCTAssertEqual(confetti?.inputType, .tap)
            
            let spinner = PatternCatalog.pattern(forID: "loading-spinner")
            XCTAssertNotNil(spinner)
            XCTAssertEqual(spinner?.inputType, .toggle)
            
            let shimmer = PatternCatalog.pattern(forID: "shimmer")
            XCTAssertNotNil(shimmer)
            XCTAssertEqual(shimmer?.inputType, .toggle)
            
            let chrome = PatternCatalog.pattern(forID: "liquid-chrome")
            XCTAssertNotNil(chrome)
            XCTAssertEqual(chrome?.inputType, .slider)
            
            let fire = PatternCatalog.pattern(forID: "fire-smoke")
            XCTAssertNotNil(fire)
            XCTAssertEqual(fire?.inputType, .toggle)
            
        }
        
    func testFilterThreeDCategory() {
        let results = PatternCatalog.filter(searchText: "", category: .threeD)
        XCTAssertEqual(results.count, 3)
        XCTAssertTrue(results.allSatisfy { $0.category == .threeD })
    }

    func testThreeDPatternLookup() {
        let cube = PatternCatalog.pattern(forID: "cube-3d")
        XCTAssertNotNil(cube)
        XCTAssertEqual(cube?.category, .threeD)
        XCTAssertEqual(cube?.inputType, .slider)

        let parallax = PatternCatalog.pattern(forID: "parallax-depth")
        XCTAssertNotNil(parallax)
        XCTAssertEqual(parallax?.inputType, .slider)

        let tilt = PatternCatalog.pattern(forID: "perspective-tilt")
        XCTAssertNotNil(tilt)
        XCTAssertEqual(tilt?.inputType, .drag)
    }

    func testEmptySearchReturnsAll() {
        let results = PatternCatalog.filter(searchText: "", category: nil)
        XCTAssertEqual(results.count, 27)
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
        XCTAssertEqual(vm.filteredPatterns.count, 27)
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
        XCTAssertEqual(vm.filteredPatterns.count, 27)
    }

    func testGalleryViewModelSearchTextFilters() {
        let vm = GalleryViewModel()
        vm.searchText = "card"
        XCTAssertEqual(vm.filteredPatterns.count, 2)
    }

    func testGalleryViewModelSearchGradient() {
        let vm = GalleryViewModel()
        vm.searchText = "gradient"
        XCTAssertEqual(vm.filteredPatterns.count, 5)
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

    func testFavoritesStoreToggle() {
        let store = FavoritesStore.shared
        store.clear()
        XCTAssertFalse(store.isFavorite("scale-pulse"))
        store.toggle("scale-pulse")
        XCTAssertTrue(store.isFavorite("scale-pulse"))
        store.toggle("scale-pulse")
        XCTAssertFalse(store.isFavorite("scale-pulse"))
    }

    func testFavoritesStoreAddRemove() {
        let store = FavoritesStore.shared
        store.clear()
        store.add("rotate")
        XCTAssertTrue(store.isFavorite("rotate"))
        store.remove("rotate")
        XCTAssertFalse(store.isFavorite("rotate"))
    }

    func testFavoritesStoreClear() {
        let store = FavoritesStore.shared
        store.add("scale-pulse")
        store.add("rotate")
        store.clear()
        XCTAssertTrue(store.favoriteIDs.isEmpty)
    }

    func testGalleryViewModelFavoritesFilter() {
        let store = FavoritesStore.shared
        store.clear()
        store.add("scale-pulse")
        let vm = GalleryViewModel(favoritesStore: store)
        XCTAssertFalse(vm.showFavoritesOnly)
        vm.toggleFavoritesFilter()
        XCTAssertTrue(vm.showFavoritesOnly)
        XCTAssertEqual(vm.filteredPatterns.count, 1)
        XCTAssertEqual(vm.filteredPatterns.first?.id, "scale-pulse")
        vm.toggleFavoritesFilter()
        XCTAssertFalse(vm.showFavoritesOnly)
        XCTAssertEqual(vm.filteredPatterns.count, 27)
        store.clear()
    }

    func testGalleryViewModelFavoritesWithSearch() {
        let store = FavoritesStore.shared
        store.clear()
        store.add("scale-pulse")
        store.add("rotate")
        let vm = GalleryViewModel(favoritesStore: store)
        vm.toggleFavoritesFilter()
        vm.searchText = "scale"
        XCTAssertEqual(vm.filteredPatterns.count, 1)
        XCTAssertEqual(vm.filteredPatterns.first?.id, "scale-pulse")
        store.clear()
    }

    func testHapticsManagerEnabled() {
        let manager = HapticsManager.shared
        manager.setEnabled(true)
        manager.impact(for: .tap)
        manager.impact(for: .slider)
        manager.impact(for: .toggle)
        manager.impact(for: .drag)
        manager.impact(for: .pinch)
        manager.impact(for: .swipe)
        manager.selection()
        manager.success()
        manager.warning()
    }

    func testHapticsManagerDisabled() {
        let manager = HapticsManager.shared
        manager.setEnabled(false)
        manager.impact(for: .tap)
        manager.impact(for: .slider)
        manager.selection()
        manager.setEnabled(true)
    }

    func testHapticsManagerToggleEnabledState() {
        let manager = HapticsManager.shared
        manager.setEnabled(false)
        manager.impact(for: .tap)
        manager.setEnabled(true)
        manager.impact(for: .tap)
    }

    func testSettingsStoreDefaults() {
        let store = SettingsStore.shared
        XCTAssertEqual(store.defaultDuration, 0.4, accuracy: 0.01)
        XCTAssertTrue(store.hapticsEnabled)
    }

    func testSettingsStoreHapticsToggle() {
        let store = SettingsStore.shared
        let original = store.hapticsEnabled
        store.hapticsEnabled = false
        XCTAssertFalse(store.hapticsEnabled)
        store.hapticsEnabled = true
        XCTAssertTrue(store.hapticsEnabled)
        store.hapticsEnabled = original
    }

    func testSettingsStoreColorScheme() {
        let store = SettingsStore.shared
        let original = store.colorScheme
        store.colorScheme = .dark
        XCTAssertEqual(store.colorScheme, .dark)
        store.colorScheme = .light
        XCTAssertEqual(store.colorScheme, .light)
        store.colorScheme = .system
        XCTAssertEqual(store.colorScheme, .system)
        store.colorScheme = original
    }

    func testSettingsStoreDefaultDuration() {
        let store = SettingsStore.shared
        let original = store.defaultDuration
        store.defaultDuration = 1.5
        XCTAssertEqual(store.defaultDuration, 1.5, accuracy: 0.01)
        store.defaultDuration = original
    }

    func testAppColorSchemeValues() {
        XCTAssertEqual(AppColorScheme.allCases.count, 3)
        XCTAssertEqual(AppColorScheme.system.title, "System")
        XCTAssertEqual(AppColorScheme.light.title, "Light")
        XCTAssertEqual(AppColorScheme.dark.title, "Dark")
    }
    
    func testVideoExportManagerInitialState() {
        let exporter = VideoExportManager()
        XCTAssertEqual(exporter.state, .idle)
        XCTAssertFalse(exporter.isRecording)
        XCTAssertFalse(exporter.isProcessing)
        XCTAssertNil(exporter.errorMessage)
    }
}
