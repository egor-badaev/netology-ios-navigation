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
        posts = [
            PostDummy(title: "Пост 1"),
            PostDummy(title: "Пост 2")
        ]
    }
}
