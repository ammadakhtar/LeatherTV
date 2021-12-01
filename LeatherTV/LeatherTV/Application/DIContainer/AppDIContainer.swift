//
//  AppDIContainer.swift
//  LeatherTV
//
//  Created by Ammad Akhtar on 28/11/2021.
//

import Foundation

final class AppDIContainer {
    
    lazy var networkService: NetworkService = {
       return DefaultNetworkService()
    }()
    
    func makeDiscoveryListDIContainer() -> DiscoveryListDIContainer {
        let dependencies = DiscoveryListDIContainer.Dependencies(networkService: networkService)
        return DiscoveryListDIContainer(dependencies: dependencies)
    }
}
