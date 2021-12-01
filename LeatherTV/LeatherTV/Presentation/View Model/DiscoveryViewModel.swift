//
//  DiscoveryViewModel.swift
//  LeatherTV
//
//  Created by Ammad Akhtar on 28/11/2021.
//

import Foundation

protocol DiscoveryViewModelDelegate: AnyObject {
    func didFetchShows()
}

final class DiscoveryViewModel {
    
    // MARK: - Variables
    
    private let fetchShowsUseCase: FetchShowsUseCaseProtocol
    private var category: Category?
    
    weak var delegate: DiscoveryViewModelDelegate?
    
    // MARK: - Init

    init(fetchShowsUseCase: FetchShowsUseCaseProtocol) {
        self.fetchShowsUseCase = fetchShowsUseCase
    }

    // MARK: - Functions

    /// Fetches the list of shows either from the internet or local storage via use case
    func fetchShowsList() {
        fetchShowsUseCase.execute() { [weak self] result in
            switch result {
            case .success(let shows):
                self?.category = shows.data.catalog.categories.first
                self?.delegate?.didFetchShows()
            case .failure(let error):
                print(error)
            }
        }
    }

    func getTrackForIndex(index: Int) -> Track? {
        return category?.tracks[index]
    }
    
    func getTrackCount() -> Int {
        category?.tracks.count ?? 0
    }
}
