//
//  RootTabBarController.swift
//  Navigation
//
//  Created by Egor Badaev on 26.12.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

class RootTabBarController: UITabBarController {
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabBar()
    }

    // MARK: - Private methods

    private func setupTabBar() {
        
        // Tab 1
        let feedViewController = FeedViewController()
        let feedViewControllerTitle = "Feed"
        feedViewController.title = feedViewControllerTitle
        
        let feedNavigationController = UINavigationController(rootViewController: feedViewController)
        
        let feedTabBarItem = UITabBarItem(title: feedViewControllerTitle, image: UIImage(named: "Home"), selectedImage: nil)
        feedNavigationController.tabBarItem = feedTabBarItem
        
        // Tab 2
        let loginViewController = LogInViewController()
        
        let profileNavigationController = UINavigationController(rootViewController: loginViewController)
        
        let profileTabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "Profile"), selectedImage: nil)
        profileNavigationController.tabBarItem = profileTabBarItem
        
        // Tab bar
        viewControllers = [feedNavigationController, profileNavigationController]
        
    }
}
