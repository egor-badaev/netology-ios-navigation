//
//  PostButtonFactory.swift
//  Navigation
//
//  Created by Egor Badaev on 09.02.2021.
//  Copyright © 2021 Egor Badaev. All rights reserved.
//

import UIKit

struct PostButtonFactory {
    static func makeButtonForPost(index: Int) -> PostButton {
        let button = PostButton(type: .system)

        button.setTitle("Show post \(index + 1)", for: .normal)
        button.sizeToFit()

        button.index = index

        return button
    }

}
