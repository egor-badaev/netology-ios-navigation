//
//  PostButtonFactory.swift
//  Navigation
//
//  Created by Egor Badaev on 05.02.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class PostButtonFactory {
    static func makeButton(forPostWithIndex index: Int) -> PostButton {
        
        let button = PostButton(type: .system)

        button.setTitle("Show post \(index + 1)", for: .normal)
        button.sizeToFit()

        button.index = index

        return button
    }
}
