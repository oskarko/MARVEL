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

    private let searchBar = UISearchBar()

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

    // MARK: - Selectors

    @objc func handleShowSearchBar() {
        presenter?.handleShowSearchBar()
    }

    // MARK: - Helpers

    func configureUI() {
        showSearchBarButton(shouldShow: true)
        searchBar.sizeToFit()
        searchBar.delegate = self
        searchBar.placeholder = "Search for a character".localized()
        definesPresentationContext = false

        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.textColor = .darkGray
            textField.backgroundColor = .white
        }

        view.backgroundColor = .white

        collectionView.register(CharacterCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = .white
        navigationItem.titleView = imageForTitleView()
    }

    // MARVEL logo for the navigation title view
    private func imageForTitleView() -> UIImageView {
        let imageView = UIImageView(image: UIImage(named: "MARVEL"))
        imageView.contentMode = .scaleAspectFit
        imageView.setDimensions(width: 80, height: 44)
        return imageView
    }

    // If shoouldShow is true, we show the search icon.
    private func showSearchBarButton(shouldShow: Bool) {
        if shouldShow {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search,
                                                                target: self,
                                                                action: #selector(handleShowSearchBar))
        } else {
            navigationItem.rightBarButtonItem = nil
        }
    }

    // Show the searchBar or the search icon + MARVEL logo.
    private func search(shouldShow: Bool) {
        showSearchBarButton(shouldShow: !shouldShow)
        searchBar.showsCancelButton = shouldShow
        navigationItem.titleView = shouldShow ? searchBar : imageForTitleView()
    }
}

// MARK: FeedPresenterToViewProtocol

extension FeedView: FeedPresenterToViewProtocol {
    func fetchCharactersWithSuccess(_ characters: [Character]) {
        self.characters = characters
    }

    func fetchCharactersWithFail(_ error: String) {
        showError(error)
    }

    func configureSearchBar(shouldShow: Bool) {
        search(shouldShow: shouldShow)

        if shouldShow {
            searchBar.becomeFirstResponder()
        }
    }

    func dismissKeyBoard() {
        searchBar.resignFirstResponder()
    }

    func showLoader() {
        DispatchQueue.main.async {
            self.showLoader(true)
        }
    }

    func dismissLoader() {
        DispatchQueue.main.async {
            self.showLoader(false)
        }
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
        presenter?.didSelectCharacter(self, character: character)
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

// MARK: - UISearchBarDelegate

extension FeedView: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let characterName = searchBar.text ?? ""
        presenter?.searchCharacter(withName: characterName)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter?.searchBarCancelButtonClicked()
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("DEBUG: Search bar did begin editing...")
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("DEBUG: Search bar did end editing...")
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("DEBUG: Search text is: \(searchText)")
    }
}
