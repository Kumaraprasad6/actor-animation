import SwiftUI
import Combine

enum GalleryRoute: Hashable {
    case detail(patternID: String)
}

@MainActor
final class GalleryCoordinator: ObservableObject {
    @Published var path = NavigationPath()

    func navigateToDetail(patternID: String) {
        path.append(GalleryRoute.detail(patternID: patternID))
    }

    func popToRoot() {
        path.removeLast(path.count)
    }
}