//
//  DiscoveryListDIContainer.swift
//  LeatherTV
//
//  Created by Ammad Akhtar on 28/11/2021.
//

import Foundation

final class DiscoveryListDIContainer {
    
    struct Dependencies {
        let networkService: NetworkService
    }

    private let dependencies: Dependencies

    // MARK: - Init

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    // MARK: - UseCases

    private func makeFetchShowsUseCase() -> FetchShowsUseCaseProtocol {
        return FetchShowsUseCase(showsRepository: makeShowsRepository())
    }

    // MARK: - Repository

    private func makeShowsRepository() -> ShowRepositoryProtocol {
        return ShowsRepository(networkService: dependencies.networkService)
    }

    // MARK: - ViewModel

    private func makeDiscoveryViewMode() -> DiscoveryViewModel {
        return DiscoveryViewModel(fetchShowsUseCase: makeFetchShowsUseCase())
    }

    // MARK: - ViewController

    func makeDiscoveryListViewController() -> DiscoveryViewController {
        return DiscoveryViewController(viewModel: makeDiscoveryViewMode())
    }
}
