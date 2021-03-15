//
//  ViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

final class FeedViewController: UIViewController {
    
    weak var coordinator: FeedCoordinator?
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGreen

        let stackView = PostWrapperView()
        stackView.toAutoLayout()
        view.addSubview(stackView)

        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        stackView.onButtonTap = { index in
            self.coordinator?.showPost(number: index)
        }
    }
}
