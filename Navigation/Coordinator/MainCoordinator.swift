//
//  MainCoordinator.swift
//  Navigation
//
//  Created by Egor Badaev on 08.02.2021.
//  Copyright © 2021 Egor Badaev. All rights reserved.
//

import UIKit

final class MainCoordinator {
    var childCoordinators: [Coordinator] = []
    private var rootWindow: UIWindow?
    private var tabBarController: UITabBarController
    
    init(rootWindow: UIWindow?) {
        self.rootWindow = rootWindow
        tabBarController = UITabBarController()
    }
    
    func start() {
        setupFeedCoordinator()
        setupProfileCoordinator()
        setupTabBarController()
        rootWindow?.rootViewController = self.tabBarController
        rootWindow?.makeKeyAndVisible()
    }
    
    private func setupFeedCoordinator() {
        let feedViewController = FeedViewController()
        let feedNavigationController = UINavigationController(rootViewController: feedViewController)
        let feedCoordinator = FeedCoordinator(navigationController: feedNavigationController)
        childCoordinators.append(feedCoordinator)
    }
    
    private func setupProfileCoordinator() {
        let loginViewController = LogInViewController()
        let profileNavigationController = UINavigationController(rootViewController: loginViewController)
        let profileCoordinator = ProfileCoordinator(navigationController: profileNavigationController)
        childCoordinators.append(profileCoordinator)
    }
    
    private func setupTabBarController() {
        var viewControllers: [UIViewController] = []
        childCoordinators.forEach {
            $0.start()
            viewControllers.append($0.navigationController)
        }
        tabBarController.viewControllers = viewControllers
    }
}
