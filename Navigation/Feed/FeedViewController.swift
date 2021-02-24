//
//  ViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

protocol FeedViewControllerOutput {
    var onTap: ((_: Int) -> Void)? { get set }
    func configure(completion: (_: PostButton) -> Void)
}

final class FeedViewController: UIViewController {
    
    weak var coordinator: FeedCoordinator?
    var viewModel: FeedViewControllerOutput
    
    var stackView: UIStackView = {

        $0.toAutoLayout()

        $0.axis = .vertical
        $0.spacing = 10.0

        return $0

    }(UIStackView())

    // MARK: - Lifecycle
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(viewModel: FeedViewControllerOutput) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGreen
        
        view.addSubview(stackView)

        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        viewModel.configure { (button) in
            stackView.addArrangedSubview(button)
        }
        
        viewModel.onTap = { (index) in
            self.coordinator?.showPost(number: index)
        }

    }
}
