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
    private var credentialsVerificator: CredentialsVerificator?

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
        feedViewController.coordinator = feedCoordinator
        childCoordinators.append(feedCoordinator)
    }
    
    private func setupProfileCoordinator() {
        credentialsVerificator = CredentialsVerificator()
        let loginViewController = LogInViewController()
        let profileNavigationController = UINavigationController(rootViewController: loginViewController)
        let profileCoordinator = ProfileCoordinator(navigationController: profileNavigationController)
        loginViewController.coordinator = profileCoordinator
        loginViewController.delegate = credentialsVerificator
        childCoordinators.append(profileCoordinator)
    }
    
    private func setupTabBarController() {
        var tabBarViewControllers: [UIViewController] = []
        childCoordinators.forEach {
            $0.start()
            tabBarViewControllers.append($0.navigationController)
        }
        
        let playerViewController = PlayerViewController()
        let playerTabBarItem = UITabBarItem(title: "Player", image: UIImage(named: "Music"), selectedImage: nil)
        playerViewController.tabBarItem = playerTabBarItem
        
        tabBarViewControllers.append(playerViewController)
        
        let videoViewController = VideoPlayerViewController()
        let videoTabBarItem = UITabBarItem(title: "Video", image: UIImage(named: "YouTube"), selectedImage: nil)
        videoViewController.tabBarItem = videoTabBarItem
        tabBarViewControllers.append(videoViewController)
        
        
        tabBarController.viewControllers = tabBarViewControllers
    }
    
}
