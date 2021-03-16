//
//  AVControlButton.swift
//  AVFoundation_Audio
//
//  Created by Egor Badaev on 10.03.2021.
//

import UIKit

class AVControlButton: UIButton {

    convenience init(imageName: String, controller: UIViewController, selector: Selector) {
        self.init()
        if #available(iOS 13.0, *) {
            self.tintColor = .label
        } else {
            self.tintColor = .black
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setImage(UIImage(named: imageName), for: .normal)
        self.addTarget(controller, action: selector, for: .touchUpInside)
    }
}
