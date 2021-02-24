//
//  FeedModel.swift
//  Navigation
//
//  Created by Egor Badaev on 09.02.2021.
//  Copyright © 2021 Egor Badaev. All rights reserved.
//

import Foundation

struct FeedModel {
    
    static let shared: FeedModel = {
        let instance = FeedModel()
        return instance
    }()
    
    let posts: [PostDummy]

    private init() {
        var posts = [PostDummy]()
        for index in 0...Int.random(in: 1...9) {
            posts.append(PostDummy(title: "Пост \(index + 1)"))
        }
        self.posts = posts
    }
}
