//
//  ViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

protocol FeedViewOutput {
    var navigationController: UINavigationController? { get set }
    func showPost(number index: Int)
}

final class FeedViewController: UIViewController {
    
    var output: FeedViewOutput
    
    required init?(coder: NSCoder) {
        output = PostViewPresenter()
        super.init(coder: coder)
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        output.navigationController = self.navigationController

        let stackView = PostWrapperView()
        stackView.toAutoLayout()
        view.addSubview(stackView)

        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        stackView.onButtonTap = { index in
            self.output.showPost(number: index)
        }
    }
}
