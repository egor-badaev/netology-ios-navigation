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
        
        let stackView = UIStackView()
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        stackView.axis = .vertical
        stackView.spacing = 10.0

        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        for (index, _) in FeedModel.shared.posts.enumerated() {
            let postButton = PostButtonFactory.makeButtonForPost(index: index)
            postButton.addTarget(self, action: #selector(postButtonTapped(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(postButton)
        }
    }

    // MARK: - Private methods

    @objc private func postButtonTapped(_ sender: PostButton) {
        guard let index = sender.index else { return }
        coordinator?.showPost(number: index)
    }
}
