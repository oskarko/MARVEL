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
    private var characters = [Character]()

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

        collectionView.register(CharacterCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = .white
        collectionView.prefetchDataSource = self

        view.backgroundColor = .white
        navigationItem.titleView = imageForTitleView()
    }

    // MARVEL logo for the navigation title view
    private func imageForTitleView() -> UIImageView {
        let imageView = UIImageView(image: UIImage(named: "MARVEL"))
        imageView.contentMode = .scaleAspectFit
        imageView.setDimensions(width: LOGO_WIDTH, height: LOGO_HEIGHT)
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

    // This method helps to calculate if a cell is the last one in the collectionView..
    func isLastCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row == characters.count - 1
            && characters.count % CHARACTERS_BY_PAGE == 0
    }
}

// MARK: FeedPresenterToViewProtocol

extension FeedView: FeedPresenterToViewProtocol {

    // MARK: - API

    func fetchCharactersWithSuccess(_ characters: [Character]) {
        self.characters = characters

        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

    func fetchCharactersWithSuccess(_ characters: [Character], indexPathsToReload: [IndexPath]) {
        self.characters.append(contentsOf: characters)

        DispatchQueue.main.async {
            self.collectionView.insertItems(at: indexPathsToReload)
        }
    }

    func fetchCharactersWithFail(_ error: String) {
        showError(error)
    }

    // MARK: - UI Helpers

    func configureSearchBar(shouldShow: Bool) {
        search(shouldShow: shouldShow)

        if shouldShow {
            searchBar.becomeFirstResponder()
        }
    }

    func scrollToTop() {
        DispatchQueue.main.async {
            self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0),
                                             at: .top,
                                             animated: true)
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

        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let character = characters[indexPath.row]
        presenter?.didSelectCharacter(self, character: character)
    }
}

// MARK: - UICollectionViewDataSourcePrefetching

extension FeedView: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        // If We're in the last cell, We'll try to fetch automatically
        // the next characters in order to have an infinite scrolling effect.
        if indexPaths.contains(where: isLastCell) {
            presenter?.searchCharacters(withName: searchBar.text.orEmpty, offset: characters.count)
          }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension FeedView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: (view.frame.width - 12) / 2, height: CELL_HEIGHT)
    }
}

// MARK: - UISearchBarDelegate

extension FeedView: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let characterName = searchBar.text.orEmpty
        presenter?.searchCharacters(withName: characterName, offset: 0)
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
