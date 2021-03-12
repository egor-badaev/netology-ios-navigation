//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Egor Badaev on 18.11.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit
import iOSIntPackage

class PostTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let reuseIdentifier = "PostTableViewCell"
    
    private let authorLabel: UILabel = {
        let authorLabel = UILabel()
        
        authorLabel.toAutoLayout()
        authorLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        authorLabel.textColor = .black
        authorLabel.numberOfLines = 2

        return authorLabel
    }()
    private let postImageView: UIImageView = {
        let imageView = UIImageView()

        imageView.toAutoLayout()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black

        return imageView
    }()
    private let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()

        descriptionLabel.toAutoLayout()
        descriptionLabel.font = .systemFont(ofSize: 14)
        descriptionLabel.textColor = .systemGray
        descriptionLabel.numberOfLines = 0

        return descriptionLabel
    }()
    private let likesLabel: UILabel = {
        let likesLabel = UILabel()

        likesLabel.setupSupplementaryLabels()

        return likesLabel
    }()
    private let viewsLabel: UILabel = {
        let viewsLabel = UILabel()

        viewsLabel.setupSupplementaryLabels()

        return viewsLabel
    }()

    // MARK: - Lyfecycle
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    // MARK: - Custom methods

    private func setupUI() {
        selectionStyle = .none
        
        contentView.addSubview(authorLabel)
        contentView.addSubview(postImageView)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(likesLabel)
        contentView.addSubview(viewsLabel)
        
        let constraints = [
            authorLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: AppConstants.margin),
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: AppConstants.margin),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -AppConstants.margin),
            postImageView.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 12.0),
            postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            postImageView.heightAnchor.constraint(equalTo: postImageView.widthAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: authorLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: authorLabel.trailingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: AppConstants.margin),
            likesLabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor) ,
            likesLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: AppConstants.margin),
            likesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -AppConstants.margin),
            viewsLabel.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor),
            viewsLabel.topAnchor.constraint(equalTo: likesLabel.topAnchor),
            viewsLabel.bottomAnchor.constraint(equalTo: likesLabel.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func configure(with post: Post) {
        authorLabel.text = post.author
        if let image = UIImage(named: post.image)  {
            ImageProcessor().processImage(sourceImage: image, filter: .sepia(intensity: 0.5)) { (image) in
                postImageView.image = image
            }
        }
        descriptionLabel.text = post.description
        likesLabel.text = "Likes: \(post.likes)"
        viewsLabel.text = "Views: \(post.views)"
    }
    
}

// Common settings for likes and views labels
extension UILabel {
    func setupSupplementaryLabels() {
        self.toAutoLayout()
        self.font = .systemFont(ofSize: 16)
        self.textColor = .black
    }
}
