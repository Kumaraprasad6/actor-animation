import SwiftUI

struct GalleryView: View {
    @StateObject private var viewModel = GalleryViewModel()
    @StateObject private var coordinator = GalleryCoordinator()
    @State private var selectedCategoryId: AnimationCategory.ID?

    private let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16),
    ]

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    searchBar
                    categoryChips
                    patternGrid
                }
                .padding(.vertical)
            }
            .background(AppColors.background)
            .navigationTitle("Animations")
            .navigationBarTitleDisplayMode(.large)
            .navigationDestination(for: GalleryRoute.self) { route in
                switch route {
                case .detail(let patternID):
                    if let pattern = PatternCatalog.pattern(forID: patternID) {
                        PatternDetailView(pattern: pattern)
                    } else {
                        Text("Pattern not found")
                    }
                }
            }
        }
        .environmentObject(coordinator)
    }

    private var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(AppColors.secondaryText)
            TextField("Search patterns", text: $viewModel.searchText)
                .textFieldStyle(.plain)
            if !viewModel.searchText.isEmpty {
                Button {
                    viewModel.searchText = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(AppColors.secondaryText)
                }
            }
        }
        .padding(12)
        .background(AppColors.secondaryBackground)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal)
    }

    private var categoryChips: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(viewModel.categories) { category in
                    let isSelected = viewModel.selectedCategory == category
                    Button {
                        viewModel.selectCategory(category)
                    } label: {
                        Label(category.title, systemImage: category.systemImageName)
                            .font(.subheadline.weight(.medium))
                            .padding(.horizontal, 14)
                            .padding(.vertical, 8)
                            .background(
                                isSelected ? AppColors.accent.opacity(0.15) : AppColors.secondaryBackground
                            )
                            .foregroundStyle(isSelected ? AppColors.accent : AppColors.primaryText)
                            .clipShape(Capsule())
                    }
                }
            }
            .padding(.horizontal)
        }
    }

    private var patternGrid: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(viewModel.filteredPatterns) { pattern in
                Button {
                    coordinator.navigateToDetail(patternID: pattern.id)
                } label: {
                    PatternCard(pattern: pattern)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal)
    }
}

private struct PatternCard: View {
    let pattern: AnimationPattern

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .fill(pattern.category.color.opacity(0.12))
                Image(systemName: pattern.category.systemImageName)
                    .font(.system(size: 32, weight: .light))
                    .foregroundStyle(pattern.category.color)
            }
            .frame(height: 100)

            VStack(alignment: .leading, spacing: 4) {
                Text(pattern.title)
                    .font(AppTypography.headline())
                    .foregroundStyle(AppColors.primaryText)
                Text(pattern.subtitle)
                    .font(AppTypography.caption())
                    .foregroundStyle(AppColors.secondaryText)
                    .lineLimit(1)
                HStack(spacing: 4) {
                    Image(systemName: pattern.inputType.systemImageName)
                        .font(.caption2)
                    Text(pattern.inputType.title)
                        .font(.caption2)
                }
                .foregroundStyle(pattern.category.color)
            }
        }
        .padding(14)
        .background(AppColors.secondaryBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

extension AnimationCategory {
    var color: Color {
        switch self {
        case .transform: .blue
        case .transition: .purple
        case .gesture: .orange
        case .shape: .teal
        case .timer: .indigo
        case .gradient: .pink
        case .effects: .green
        case .threeD: .cyan
        }
    }
}

#Preview {
    GalleryView()
}