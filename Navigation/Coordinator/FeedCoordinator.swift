//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Egor Badaev on 08.02.2021.
//  Copyright © 2021 Egor Badaev. All rights reserved.
//

import UIKit

final class FeedCoordinator: Coordinator {
    var childCoordinators: [Coordinator]    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        childCoordinators = []
        self.navigationController = navigationController
    }
    
    func start() {
        let feedViewControllerTitle = "Feed"
        if let feedViewController = navigationController.viewControllers.first as? FeedViewController {
            feedViewController.title = feedViewControllerTitle
        }
        let feedTabBarItem = UITabBarItem(title: feedViewControllerTitle, image: UIImage(named: "Home"), selectedImage: nil)
        navigationController.tabBarItem = feedTabBarItem

    }
}
