//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Egor Badaev on 05.11.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

class ProfileHeaderView: UIView {

    // MARK: - Constants

    private let margin: CGFloat = 16.0
    private let radius: CGFloat = 4.0
    private let avatarSize: CGFloat = 110.0

    // MARK: - Setup UI

    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()

        imageView.image = #imageLiteral(resourceName: "profilePhoto")
        imageView.layer.cornerRadius = avatarSize / 2
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.clipsToBounds = true

        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()

        label.text = "John Appleseed"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.sizeToFit()

        return label
    }()

    private let statusLabel: UILabel = {
        let label = UILabel()

        label.text = "Waiting for something..."
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        label.sizeToFit()

        return label

    }()

    private lazy var statusButton: UIButton = {
        let button = UIButton()

        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Show status", for: .normal)
        button.clipsToBounds = true
        button.layer.masksToBounds = false
        button.layer.cornerRadius = radius
        button.layer.shadowOffset = CGSize(width: radius, height: radius)
        button.layer.shadowRadius = radius
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.addTarget(self, action: #selector(statusButtonTapped), for: .touchUpInside)

        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        print("Init with frame")

        addSubview(avatarImageView)
        addSubview(titleLabel)
        addSubview(statusLabel)
        addSubview(statusButton)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Positioning

    override func layoutSubviews() {
        super.layoutSubviews()

        print("layoutSubviews")

        guard let superview = superview else {
            print("Sorry, no superview")
            return
        }

        avatarImageView.frame = CGRect(
            x: superview.safeAreaInsets.left + margin,
            y: superview.safeAreaInsets.top + margin,
            width: avatarSize,
            height: avatarSize
        )

        titleLabel.frame = CGRect(
            x: avatarImageView.frame.maxX + margin,
            y: superview.safeAreaInsets.top + 27.0,
            width: bounds.width - avatarImageView.bounds.width - margin * 3 - superview.safeAreaInsets.left - superview.safeAreaInsets.right,
            height: titleLabel.bounds.height
        )

        statusButton.frame = CGRect(
            x: superview.safeAreaInsets.left + margin,
            y: avatarImageView.frame.maxY + margin,
            width: bounds.width - margin * 2 - superview.safeAreaInsets.left - superview.safeAreaInsets.right,
            height: 50
        )

        statusLabel.frame = CGRect(
            x: titleLabel.frame.minX,
            y: statusButton.frame.minY - 34.0 - statusLabel.bounds.height,
            width: titleLabel.frame.width,
            height: statusLabel.bounds.height
        )
    }

    // MARK: - Actions

    @objc private func statusButtonTapped() {
        guard let statusText = statusLabel.text else {
            print("No status has been set!")
            return
        }
        print("Status: \(statusText)")
    }

}
