//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Egor Badaev on 05.11.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    private let headerView = ProfileHeaderView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        view.addSubview(headerView)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        headerView.frame = CGRect(
            x: 0,
            y: 0,
            width: view.bounds.width,
            height: view.bounds.height
        )
    }
}
