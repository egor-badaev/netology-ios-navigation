//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Egor Badaev on 05.11.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    weak var coordinator: ProfileCoordinator?
    
    //MARK: - Subviews
    
    private lazy var postsTableView: UITableView = {
        let tableView = UITableView()
        
        tableView.toAutoLayout()
        
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.reuseIdentifier)
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.reuseIdentifier)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        return tableView
    }()
    
    private let headerView = ProfileHeaderView()

    private lazy var tintView: UIView = {
        let tintView = UIView()
        tintView.backgroundColor = .black
        tintView.layer.opacity = 0

        return tintView
    }()
    
    private lazy var closeView: UIButton = {
        let closeView = UIButton()

        closeView.frame.size.width = 28
        closeView.frame.size.height = 28
        closeView.setImage(#imageLiteral(resourceName: "close"), for: .normal)
        closeView.setImage(#imageLiteral(resourceName: "close").alpha(0.7), for: .selected)
        closeView.setImage(#imageLiteral(resourceName: "close").alpha(0.7), for: .highlighted)
        closeView.setImage(#imageLiteral(resourceName: "close").alpha(0.7), for: .focused)

        closeView.addTarget(self, action: #selector(closeTapped(_:)), for: .touchUpInside)
        
        return closeView
    }()

    // MARK: - Properties

    private var zoomedSize: CGFloat {
        min(view.bounds.height, view.bounds.width)
    }
    private var zoomedAbsoluteFrame: CGRect {
        CGRect(
            x: self.view.bounds.width / 2 - self.zoomedSize / 2,
            y: self.view.bounds.height / 2 - self.zoomedSize / 2,
            width: self.zoomedSize,
            height: self.zoomedSize
        )
    }
    private var isZoomed: Bool = false
    private var originalAbsoluteFrame: CGRect {
        let absoluteOriginX = postsTableView.frame.origin.x + headerView.frame.origin.x + headerView.avatarContainerView.frame.origin.x
        let absoluteOriginY = postsTableView.frame.origin.y - postsTableView.contentOffset.y + headerView.frame.origin.y + headerView.avatarContainerView.frame.origin.y

        return CGRect(x: absoluteOriginX, y: absoluteOriginY, width: headerView.avatarContainerView.bounds.width, height: headerView.avatarContainerView.bounds.height)

    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tintView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)

        closeView.frame = CGRect(
            x: view.bounds.width - view.safeAreaInsets.right - AppConstants.margin - closeView.bounds.width,
            y: view.safeAreaInsets.top + AppConstants.margin,
            width: closeView.bounds.width,
            height: closeView.bounds.height
        )
        
        if isZoomed {
            headerView.avatarImageView.frame = zoomedAbsoluteFrame
        }
    }

    // MARK: - Private methods

    private func setupUI() {
        
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            // Fallback on earlier versions
            view.backgroundColor = .white
        }
        
        view.addSubview(postsTableView)
        
        let constraints = [
            postsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            postsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            postsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            postsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(avatarTapped(_:)))
        headerView.avatarImageView.isUserInteractionEnabled = true
        headerView.avatarImageView.addGestureRecognizer(tapGestureRecognizer)
    }

    @objc private func avatarTapped(_ sender: Any) {
        
        guard !isZoomed, let window = view.window else { return }
        
        window.addSubview(tintView)

        NSLayoutConstraint.deactivate(headerView.avatarConstraints)
        headerView.avatarImageView.removeFromSuperview()
        headerView.avatarImageView.translatesAutoresizingMaskIntoConstraints = true
        headerView.avatarImageView.frame = originalAbsoluteFrame
        headerView.avatarImageView.isUserInteractionEnabled = false
        window.addSubview(headerView.avatarImageView)
        
        closeView.layer.opacity = 0
        window.addSubview(closeView)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.headerView.avatarImageView.frame = self.zoomedAbsoluteFrame
            self.headerView.avatarImageView.layer.cornerRadius = 0
            self.tintView.layer.opacity = 0.5
        }) { _ in
            UIView.animate(withDuration: 0.3) {
                self.closeView.layer.opacity = 1.0
            } completion: { _ in
                self.isZoomed = true
            }
        }
    }
    
    @objc private func closeTapped(_ sender: Any) {

        guard isZoomed else { return }
        
        UIView.animate(withDuration: 0.3) {
            self.closeView.layer.opacity = 0
        } completion: { _ in
            UIView.animate(withDuration: 0.5) {
                self.headerView.avatarImageView.frame = self.originalAbsoluteFrame
                self.headerView.avatarImageView.layer.cornerRadius = self.originalAbsoluteFrame.width / 2
                self.tintView.layer.opacity = 0
            } completion: { _ in
                self.headerView.avatarImageView.removeFromSuperview()
                self.headerView.avatarImageView.toAutoLayout()
                self.headerView.avatarImageView.isUserInteractionEnabled = true
                self.headerView.avatarContainerView.addSubview(self.headerView.avatarImageView)
                NSLayoutConstraint.activate(self.headerView.avatarConstraints)
                
                self.closeView.removeFromSuperview()
                self.tintView.removeFromSuperview()
                self.isZoomed = false
            }
        }
    }
    
}

// MARK: - Table View Data Source

extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return Post.samplePosts.count
        default:
            return .zero
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotosTableViewCell.reuseIdentifier, for: indexPath) as? PhotosTableViewCell else {
                return UITableViewCell()
            }
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.reuseIdentifier, for: indexPath) as? PostTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: Post.samplePosts[indexPath.row])
            return cell

        default:
            return UITableViewCell()
        }
    }

}

// MARK: - Table View Delegate

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 0 else { return nil }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard section == 0 else { return .zero }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard indexPath.section <= 1 else { return .zero }
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section == 0 && indexPath.row == 0 else { return }
        tableView.deselectRow(at: indexPath, animated: true)
        coordinator?.showPhotos()
    }
}
