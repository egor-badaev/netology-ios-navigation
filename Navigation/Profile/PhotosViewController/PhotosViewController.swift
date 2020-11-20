//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Egor Badaev on 20.11.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {

    // MARK: - Properties

    private enum Config {
        static let inset: CGFloat = 8.0
        static let itemsPerLine: Int = 3
    }

    private lazy var galleryView: UICollectionView = {
        let galleryViewFlowLayout = UICollectionViewFlowLayout()
        let galleryView = UICollectionView(frame: .zero, collectionViewLayout: galleryViewFlowLayout)

        galleryView.toAutoLayout()
        galleryView.backgroundColor = .white

        galleryView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.reuseIdentifier)

        galleryView.dataSource = self
        galleryView.delegate = self

        return galleryView
    }()
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }

    // MARK: - Private methods

    private func setupUI() {
        title = "Photo Gallery"

        view.backgroundColor = .white
        view.addSubview(galleryView)

        /**
         I am deliberately not sticking top and bottom anchors to safe area
         to achieve opaque navigation bar effect (when images go under it upon scrolling)
         */
        let constraints = [
            galleryView.topAnchor.constraint(equalTo: view.topAnchor),
            galleryView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            galleryView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            galleryView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]

        NSLayoutConstraint.activate(constraints)

    }
}

// MARK: - Collection View Data Source

extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard section == 0 else { return .zero }
        return PhotoGalleryData.imageNames.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard indexPath.section == 0,
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.reuseIdentifier, for: indexPath) as? PhotosCollectionViewCell else {
            return UICollectionViewCell()
        }

        cell.configure(withImageNamed: PhotoGalleryData.imageNames[indexPath.item])
        return cell
    }

}

// MARK: - Collection View Delegate

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // top & bottom edge insets automatically adjust to safe area
        UIEdgeInsets(top: Config.inset, left: Config.inset, bottom: Config.inset, right: Config.inset)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        Config.inset
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        Config.inset
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let side = ( collectionView.frame.width - Config.inset * 2 - Config.inset * (CGFloat(Config.itemsPerLine) - 1) ) / CGFloat(Config.itemsPerLine)

        return CGSize(width: side, height: side)
    }
}
