//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Egor Badaev on 19.11.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let reuseIdentifier = "PhotosTableViewCell"
    
    private enum Config {
        static let margin: CGFloat = 12.0
        static let spacing: CGFloat = 8.0
        static let numberOfPhotos: Int = 4
        static let photoHeight: CGFloat = 68.0
        static let cornerRadius: CGFloat = 6.0
    }
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        
        titleLabel.toAutoLayout()
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        titleLabel.text = "Photos"
        
        return titleLabel
    }()
    
    private let disclosureImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.toAutoLayout()
        imageView.image = #imageLiteral(resourceName: "disclosure")
        
        return imageView
    }()
    
    private lazy var photosView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.toAutoLayout()
        
        stackView.axis = .horizontal
        stackView.spacing = Config.spacing
        
        for i in 0...3 {

            let imageView = UIImageView()

            imageView.contentMode = .scaleAspectFill
            imageView.image = UIImage(named: PhotoGalleryData.imageNames[i])

            imageView.layer.masksToBounds = true
            imageView.layer.cornerRadius = Config.cornerRadius
            
            stackView.addArrangedSubview(imageView)
        }
        
        return stackView
    }()
    
    private var imageWidthConstraints: [NSLayoutConstraint] = []
    
    private var photoWidth: CGFloat {
        ( contentView.frame.width - 2 * Config.margin - ( CGFloat(Config.numberOfPhotos) - 1 ) * Config.spacing ) / CGFloat(Config.numberOfPhotos)
    }
    
    // MARK: - Life cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        adjustPhotosWidth()
    }

    // MARK: - Custom methods
    
    private func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(disclosureImageView)
        contentView.addSubview(photosView)
        
        var constraints = [
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Config.margin),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Config.margin),
            disclosureImageView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            disclosureImageView.heightAnchor.constraint(equalToConstant: 16),
            disclosureImageView.widthAnchor.constraint(equalToConstant: 16),
            disclosureImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Config.margin),
            photosView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Config.margin),
            photosView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            photosView.trailingAnchor.constraint(equalTo: disclosureImageView.trailingAnchor),
            photosView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Config.margin)
        ]
        
        for photoView in photosView.arrangedSubviews {
            constraints.append(photoView.heightAnchor.constraint(equalToConstant: Config.photoHeight))

            // create constraint with a dummy value
            let widthConstraint = photoView.widthAnchor.constraint(equalToConstant: photoWidth)
            // store it to set the correct value and activate later
            imageWidthConstraints.append(widthConstraint)
        }
        
        NSLayoutConstraint.activate(constraints)
    }

    private func adjustPhotosWidth() {
        guard !imageWidthConstraints.isEmpty else { return }

        for constraint in imageWidthConstraints {

            constraint.constant = photoWidth
            
            if !constraint.isActive {
                constraint.isActive = true
            }
        }
    }

}
