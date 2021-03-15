//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Egor Badaev on 08.02.2021.
//  Copyright © 2021 Egor Badaev. All rights reserved.
//

import UIKit

final class ProfileCoordinator: Coordinator {
    var childCoordinators: [Coordinator]
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        childCoordinators = []
        self.navigationController = navigationController
    }
        
    func start() {
        let profileTabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "Profile"), selectedImage: nil)
        navigationController.tabBarItem = profileTabBarItem
    }
    
    func login() {
        let profileViewController = ProfileViewController()
        profileViewController.coordinator = self
        navigationController.pushViewController(profileViewController, animated: true)
    }
    
    func showPhotos() {
        navigationController.pushViewController(PhotosViewController(), animated: true)
    }
}
