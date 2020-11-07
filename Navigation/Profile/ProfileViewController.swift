//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Egor Badaev on 05.11.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupBottomButton()
    }

    // MARK: - Private methods

    private func setupBottomButton() {

        // Добавить кнопку
        let bottomButton = UIButton()
        view.addSubview(bottomButton)

        // Быстрая настройка внешнего вида
        bottomButton.backgroundColor = .black
        bottomButton.setTitleColor(.white, for: .normal)
        bottomButton.setTitle("Tap me!", for: .normal)

        // Настройки из задания
        bottomButton.translatesAutoresizingMaskIntoConstraints = false
        bottomButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        bottomButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        bottomButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true

        // Сделать кнопку чуть-чуть побольше для красоты
        let bottomButtonHeightConstraint = NSLayoutConstraint(item: bottomButton,
                                                  attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: nil,
                                                  attribute: .notAnAttribute,
                                                  multiplier: 1,
                                                  constant: 50)
        bottomButtonHeightConstraint.isActive = true
        bottomButton.addConstraint(bottomButtonHeightConstraint)
    }
}
