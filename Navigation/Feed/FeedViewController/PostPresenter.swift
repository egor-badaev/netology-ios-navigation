//
//  PostPresenter.swift
//  Navigation
//
//  Created by Egor Badaev on 05.02.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class PostViewPresenter: FeedViewOutput {
    
    var navigationController: UINavigationController?
    
    func showPost(number index: Int) {
        
        guard let postViewController = navigationController?.storyboard?.instantiateViewController(withIdentifier: String(describing: PostViewController.self)) as? PostViewController else {
            return
        }
        
        postViewController.post = FeedModel.shared.posts[index]
        navigationController?.pushViewController(postViewController, animated: true)
        
    }
    
}
