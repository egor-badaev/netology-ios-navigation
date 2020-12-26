//
//  PostViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {
    
    var post: PostDummy?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = post?.title
        
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemPink
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped(_:)))
    }
    
    @objc func addButtonTapped(_ sender: Any) {

        let infoViewController = InfoViewController()
        navigationController?.present(infoViewController, animated: true, completion: nil)
    }
}
