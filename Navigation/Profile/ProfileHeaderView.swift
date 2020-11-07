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

    private let radius: CGFloat = 4.0
    private let defaultStatusText = "Waiting for something..."

    // MARK: - UI

    @IBOutlet private var avatarImageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var statusLabel: UILabel!
    @IBOutlet private var statusTextField: StatusTextField!
    @IBOutlet private var statusButton: UIButton!

    private let statusTextFieldBackgroundLayer = CALayer()
    private lazy var statusText: String = defaultStatusText

    // MARK: - Init UI

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        setupAvatarImageView()
        setupStatusLabel()
        setupStatusButton()
        setupStatusTextFieldBackgroundLayer()
        setupStatusTextField()
    }
    // MARK: - Setup UI

    private func setupAvatarImageView() {
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.width / 2
        avatarImageView.layer.borderWidth = 3
        avatarImageView.layer.borderColor = UIColor.white.cgColor
    }

    private func setupStatusLabel() {
        // В IB нет цвета gray! Есть systemGray, есть lightGray, darkGray, но просто gray нет
        statusLabel.textColor = .gray
        statusLabel.text = defaultStatusText
    }

    private func setupStatusButton() {
        statusButton.layer.masksToBounds = false
        statusButton.layer.cornerRadius = radius
        statusButton.layer.shadowOffset = CGSize(width: radius, height: radius)
        statusButton.layer.shadowRadius = radius
        statusButton.layer.shadowColor = UIColor.black.cgColor
        statusButton.layer.shadowOpacity = 0.7

    }

    private func setupStatusTextField() {
        statusTextField.layer.masksToBounds = true
        statusTextField.layer.addSublayer(statusTextFieldBackgroundLayer)
    }

    private func setupStatusTextFieldBackgroundLayer() {
        statusTextFieldBackgroundLayer.masksToBounds = true
        statusTextFieldBackgroundLayer.borderColor = UIColor.black.cgColor
        statusTextFieldBackgroundLayer.borderWidth = 1.0
        statusTextFieldBackgroundLayer.cornerRadius = 12.0
        statusTextFieldBackgroundLayer.backgroundColor = UIColor.white.cgColor
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        statusTextFieldBackgroundLayer.frame = CGRect(
            x: 0,
            y: 0,
            width: statusTextField.bounds.width,
            height: statusTextField.bounds.height
        )
    }

    // MARK: - Actions

    @IBAction func statusButtonTapped(_ sender: Any) {
        statusLabel.text = statusText

        // Очистить текстовое поле после установки статуса
        statusTextField.text = ""
    }

    @IBAction func statusTextFieldChanged(_ sender: Any) {
        guard let textField = sender as? StatusTextField,
              let statusText = textField.text else {
            print("No status has been entered!")
            return
        }
        self.statusText = statusText
    }

}
