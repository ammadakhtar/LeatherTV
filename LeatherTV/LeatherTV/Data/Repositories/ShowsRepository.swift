//
//  ShowsRepository.swift
//  LeatherTV
//
//  Created by Ammad Akhtar on 28/11/2021.
//

import Foundation

protocol ShowRepositoryProtocol: AnyObject {
    func fetchShows(complete completion: @escaping (Result<Shows, Error>) -> Void)
}

final class ShowsRepository: ShowRepositoryProtocol {
    
    // MARK: - Variables

    private let networkService: NetworkService
        
    // MARK: - Init
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    /// Fetches the shows from the available dataSource
    ///
    func fetchShows(complete completion: @escaping (Result<Shows, Error>) -> Void) {
        
        fetchShowsFromJsonFile { result in
            switch result {
            case .success(let shows):
                completion(.success(shows))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        // As we are only fetching data from local json file for the sake of this challenge.
        // But I have also written the network layer, uncomment the following function when fetching data from server, after configuring the NetworkRequest and Urls
        /*
        self.fetchShowsFromInternet { result in
            switch result {
            case .success(let shows):
                completion(.success(shows))
            case .failure(let error):
                completion(.failure(error))
            }
        }
         */
    }
    
    func fetchShowsFromJsonFile(complete completion: @escaping (Result<Shows, Error>) -> Void) {
       let decoder = JSONDecoder()
       guard
            let url = Bundle.main.url(forResource: "shows", withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let shows = try? decoder.decode(Shows.self, from: data)
       else {
           completion(.failure(CustomError.unableToReadFile))
           return
       }

        completion(.success(shows))
    }
    
    /// Fetches the shows from the internet
    ///
    private func fetchShowsFromInternet(complete completion: @escaping (Result<Shows, Error>) -> Void) {
        networkService.request(ShowRequest()) { result in
            switch result {
            case .success(let shows):
                completion(.success(shows))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
