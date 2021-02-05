//
//  PostWrapperView.swift
//  Navigation
//
//  Created by Egor Badaev on 05.02.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class PostWrapperView: UIStackView {

    // MARK: - Properties
        
    var onButtonTap: ((_ index: Int) -> Void)?
    
    // MARK: - Life cycle
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.axis = .vertical
        self.spacing = 10.0

        FeedModel.shared.posts.enumerated().forEach { (index, _) in
            let postButton = PostButtonFactory.makeButton(forPostWithIndex: index)
            postButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            self.addArrangedSubview(postButton)
        }
    }
    

    // MARK: - Actions
    
    @objc private func buttonTapped(_ sender: Any) {

        guard let postButton = sender as? PostButton,
              let index = postButton.index,
              FeedModel.shared.posts.indices.contains(index) else {
            return
        }

        onButtonTap?(index)
    }
}
