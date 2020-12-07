//
//  FeedView.swift
//  Marvel
//
//  Created by Oscar Rodriguez Garrucho on 7/12/20.
//  Copyright © 2020 Little Monster. All rights reserved.
//

import Foundation
import UIKit

private let reuseIdentifier = "CharacterCell"

class FeedView: UICollectionViewController {

    // MARK: Properties

    var presenter: FeedViewToPresenterProtocol?

    private var characters = [Character]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        presenter?.viewDidLoad()
    }

    // MARK: - Helpers

    func configureUI() {
        view.backgroundColor = .white

        collectionView.register(CharacterCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = .white

        let imageView = UIImageView(image: UIImage(named: "MARVEL"))
        imageView.contentMode = .scaleAspectFit
        imageView.setDimensions(width: 80, height: 44)
        navigationItem.titleView = imageView
    }
}

// MARK: FeedPresenterToViewProtocol

extension FeedView: FeedPresenterToViewProtocol {
    func fetchCharactersWithSuccess(_ characters: [Character]) {
        self.characters = characters
    }

    func fetchCharactersWithFail() {

    }
}

// MARK: - UICollectionViewDelegate/DataSource

extension FeedView {
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                      for: indexPath) as! CharacterCell

        cell.character = characters[indexPath.row]
        //cell.delegate = self

        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let character = characters[indexPath.row]
//        let controller = TweetController(tweet: tweet)
//        navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension FeedView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: (view.frame.width - 12) / 2, height: 200)
    }
}
