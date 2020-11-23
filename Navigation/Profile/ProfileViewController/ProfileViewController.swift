//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Egor Badaev on 05.11.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    //MARK: - Properties
    
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

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

    // MARK: - Private methods

    private func setupUI() {
        view.addSubview(postsTableView)
        
        let constraints = [
            postsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            postsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            postsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            postsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
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
        navigationController?.pushViewController(PhotosViewController(), animated: true)
    }
}
