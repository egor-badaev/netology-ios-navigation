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
        let feedTabBarItem = UITabBarItem(title: AppConstants.feedViewControllerTitle, image: UIImage(named: "Home"), selectedImage: nil)
        navigationController.tabBarItem = feedTabBarItem
    }
        
    func showPost(number index: Int) {

        let postViewController = PostViewController()
        postViewController.coordinator = self
        
        let post = FeedModel.shared.posts[index]
        postViewController.title = post.title

        navigationController.pushViewController(postViewController, animated: true)
    }
    
    func showPostInfo() {
        let infoViewController = InfoViewController()
        infoViewController.coordinator = self
        navigationController.present(infoViewController, animated: true, completion: nil)
    }
    
    func showDeletePostAlert(presentedOn viewController: UIViewController) {
        let alertController = UIAlertController(title: "Удалить пост?", message: "Пост нельзя будет восстановить", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Отмена", style: .default) { _ in
            print("Отмена")
        }
        let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { _ in
            print("Удалить")
        }
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        
        viewController.present(alertController, animated: true, completion: nil)
    }
}
