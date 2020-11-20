//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Egor Badaev on 20.11.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties

    static let reuseIdentifier = "PhotosCollectionViewCell"
    
    private let photoImageView: UIImageView = {
        let photoImageView = UIImageView()

        photoImageView.toAutoLayout()

        photoImageView.contentMode = .scaleAspectFill
        photoImageView.clipsToBounds = true

        return photoImageView
    }()

    // MARK: - Life cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Custom methods

    func configure(withImageNamed imageName: String) {
        photoImageView.image = UIImage(named: imageName)
    }

    private func setupUI() {
        addSubview(photoImageView)

        let constraints = [
            photoImageView.topAnchor.constraint(equalTo: topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }

}
