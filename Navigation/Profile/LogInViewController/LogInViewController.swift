//
//  LogInViewController.swift
//  Navigation
//
//  Created by Egor Badaev on 17.11.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let logoSize: CGFloat = 100.0
        static let logoMargin: CGFloat = 120.0
        static let fieldHeight: CGFloat = 50.0
        static let cornerRadius: CGFloat = 10.0
    }
    
    // MARK: - Properties
    
    private let scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        
        scrollView.toAutoLayout()
        scrollView.backgroundColor = .white
        scrollView.contentInset.bottom = .zero

        return scrollView
    }()
    
    private let contentView: UIView = {
        let contentView = UIView()
        
        contentView.toAutoLayout()
        
        return contentView
    }()
    
    private let logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        
        logoImageView.toAutoLayout()
        logoImageView.image = #imageLiteral(resourceName: "logo")
        
        return logoImageView
    }()
    
    private let emailTextField: UITextField = {
       let emailTextField = InputTextField()
        
        emailTextField.setupCommonProperties()
        emailTextField.placeholder = "Email or phone"
                
        return emailTextField
    }()
    
    private let passwordTextField: UITextField = {
        let passwordTextField = InputTextField()
        
        passwordTextField.setupCommonProperties()
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        
        return passwordTextField
    }()
    
    private lazy var inputStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.toAutoLayout()
        
        stackView.spacing = -1.0
        stackView.axis = .vertical
        
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        
        stackView.layer.masksToBounds = true
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.layer.borderWidth = 1.0
        stackView.layer.cornerRadius = Constants.cornerRadius
        
        return stackView
    }()
    
    private lazy var loginButton: UIButton = {
        let loginButton = UIButton()
        
        loginButton.toAutoLayout()

        loginButton.setTitle("Log in", for: .normal)

        loginButton.setTitleColor(.white, for: .normal)
        loginButton.setTitleColor(UIColor(white: 1, alpha: 0.8), for: .disabled)
        loginButton.setTitleColor(UIColor(white: 1, alpha: 0.8), for: .highlighted)
        loginButton.setTitleColor(UIColor(white: 1, alpha: 0.8), for: .focused)
        loginButton.setTitleColor(UIColor(white: 1, alpha: 0.8), for: .selected)

        loginButton.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel"), for: .normal)
        loginButton.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(0.8), for: .disabled)
        loginButton.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(0.8), for: .highlighted)
        loginButton.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(0.8), for: .focused)
        loginButton.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(0.8), for: .selected)
        
        loginButton.layer.masksToBounds = true
        loginButton.layer.cornerRadius = Constants.cornerRadius
        
        loginButton.addTarget(self, action: #selector(performLogin(_:)), for: .touchUpInside)

        return loginButton
    }()

    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    
    // MARK: - Keyboard life cycle
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            scrollView.contentInset.bottom = keyboardSize.height
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset.bottom = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }

    // MARK: - Actions
    
    @objc private func performLogin(_ sender: Any) {
        guard let navigationController = self.navigationController else {
            return
        }
        
        let profileViewController = ProfileViewController()
        
        navigationController.pushViewController(profileViewController, animated: true)
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        
        navigationController?.navigationBar.isHidden = true
        
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            // Fallback on earlier versions
            view.backgroundColor = .white
        }
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(logoImageView)
        contentView.addSubview(inputStackView)
        contentView.addSubview(loginButton)
        
        let constraints = [
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.logoMargin),
            logoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: Constants.logoSize),
            logoImageView.heightAnchor.constraint(equalToConstant: Constants.logoSize),
            
            inputStackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: Constants.logoMargin),
            inputStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: AppConstants.margin),
            inputStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -AppConstants.margin),
            emailTextField.heightAnchor.constraint(equalToConstant: Constants.fieldHeight),
            passwordTextField.heightAnchor.constraint(equalToConstant: Constants.fieldHeight),
            
            loginButton.topAnchor.constraint(equalTo: inputStackView.bottomAnchor, constant: AppConstants.margin),
            loginButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: AppConstants.margin),
            loginButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -AppConstants.margin),
            loginButton.heightAnchor.constraint(equalToConstant: Constants.fieldHeight),
            loginButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }

}

extension UITextField {
    func setupCommonProperties() {
        self.toAutoLayout()
        if #available(iOS 13.0, *) {
            self.backgroundColor = UIColor.systemGray6
        } else {
            // Fallback on earlier versions
            self.backgroundColor = UIColor(red: 242.0 / 255.0, green: 242.0 / 255.0, blue: 247.0 / 255.0, alpha: 1.0)
        }
        self.textColor = .black
        self.tintColor = UIColor(named: AppConstants.accentColor)
        self.autocapitalizationType = .none
        self.font = UIFont.systemFont(ofSize: 16)
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
}
