//
//  SceneDelegate.swift
//  LeatherTV
//
//  Created by Ammad Akhtar on 28/11/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    let appDIContainer = AppDIContainer()
    var appFlowCoodinator: AppFlowCoordinator?
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        appFlowCoodinator = AppFlowCoordinator(appDIContainer: appDIContainer)
        window.rootViewController = appFlowCoodinator?.start()
        self.window = window
        window.makeKeyAndVisible()
    }
}

