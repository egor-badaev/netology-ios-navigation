//
//  FeedViewModel.swift
//  Navigation
//
//  Created by Egor Badaev on 24.02.2021.
//  Copyright © 2021 Egor Badaev. All rights reserved.
//

import Foundation

class FeedViewModel: FeedViewControllerOutput {
    
    var onTap: ((_: Int) -> Void)?
    
    func configure(completion: (_: PostButton) -> Void) {
        for (index, _) in FeedModel.shared.posts.enumerated() {
            let postButton = PostButtonFactory.makeButtonForPost(index: index)
            postButton.addTarget(self, action: #selector(postButtonTapped(_:)), for: .touchUpInside)
            completion(postButton)
        }
    }

    // MARK: - Private methods

    @objc private func postButtonTapped(_ sender: PostButton) {
        guard let index = sender.index else { return }
        onTap?(index)
    }
}
