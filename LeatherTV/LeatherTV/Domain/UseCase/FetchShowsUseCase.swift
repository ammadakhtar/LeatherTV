//
//  FetchShowsUseCase.swift
//  LeatherTV
//
//  Created by Ammad Akhtar on 28/11/2021.
//

import Foundation

protocol FetchShowsUseCaseProtocol: AnyObject {
    func execute(complete completion: @escaping (Result<Shows, Error>) -> Void)
}

final class FetchShowsUseCase: FetchShowsUseCaseProtocol {
    private let showsRepository: ShowRepositoryProtocol
    
    // MARK: - Init
    
    init(showsRepository: ShowRepositoryProtocol) {
        self.showsRepository = showsRepository
    }
    
    // MARK: - FetchShowsUseCaseProtocol
    
    /// Executes the given useCase of fetching the shows
    ///
    func execute(complete completion: @escaping (Result<Shows, Error>) -> Void) {
        
        showsRepository.fetchShows { result in
            switch result {
            case .success(let shows):
                completion(.success(shows))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
