//
//  AppFlowCoordinator.swift
//  LeatherTV
//
//  Created by Ammad Akhtar on 28/11/2021.
//

import UIKit

final class AppFlowCoordinator {

    var appDIContainer: AppDIContainer
    
    init(appDIContainer: AppDIContainer) {
        self.appDIContainer = appDIContainer
    }

    // Starts the flow of the application
    func start() -> DiscoveryViewController {
        let discoveryListDIContainer = appDIContainer.makeDiscoveryListDIContainer()
        return discoveryListDIContainer.makeDiscoveryListViewController()
    }
}
