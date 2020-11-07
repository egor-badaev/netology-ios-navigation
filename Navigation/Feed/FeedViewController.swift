//
//  ViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

final class FeedViewController: UIViewController {

    // MARK: - properties
    
    private let posts: [Post] = {
        var posts: [Post] = []

        /**
         По условиям задачи добавить нужно всего две кнопки, но текущая модель
         позволяет добавлять сколько угодно кнопок (пока не закончится экран)

         Для этого нужно добавлять эелементы в массив `posts` - для каждого
         из них создастся кнопка с переходом на соответствующий пост
         */
        posts.append(Post(title: "Пост 1"))
        posts.append(Post(title: "Пост 2"))

        return posts
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        let stackView = UIStackView()
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        stackView.axis = .vertical
        stackView.spacing = 10.0

        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        for (index, _) in posts.enumerated() {
            let postButton = buttonForPost(index: index)
            stackView.addArrangedSubview(postButton)
        }
    }

    // MARK: - Private methods

    private func buttonForPost(index: Int) -> PostButton {
        let button = PostButton(type: .system)

        button.setTitle("Show post \(index + 1)", for: .normal)
        button.sizeToFit()
        button.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)

        button.post = posts[index]

        return button
    }

    @objc private func buttonTapped(sender: Any) {

        guard let navigationController = self.navigationController,
              let storyboard = self.storyboard else {
            return
        }

        guard let postViewController = storyboard.instantiateViewController(withIdentifier: String(describing: PostViewController.self)) as? PostViewController else {
            return
        }

        guard let postButton = sender as? PostButton,
              let post = postButton.post else {
            return
        }

        postViewController.post = post

        navigationController.pushViewController(postViewController, animated: true)
    }
}
