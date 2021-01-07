//
//  FeedPresenter.swift
//  Marvel
//
//  Created by Oscar Rodriguez Garrucho on 7/12/20.
//  Copyright © 2020 Little Monster. All rights reserved.
//

import Foundation

class FeedPresenter {

    // MARK: Properties

    weak var view: FeedPresenterToViewProtocol?
    private let interactor: FeedPresenterToInteractorProtocol
    private let router: FeedPresenterToRouteProtocol

    private var characters = [Character]()
    var offset: Int = 0

    // MARK: Lifecycle

    init(interactor: FeedPresenterToInteractorProtocol, router: FeedPresenterToRouteProtocol) {
        self.interactor = interactor
        self.router = router
    }

    // MARK: - Helpers

    private func calculateIndexPathsToReload(from newCharacters: [Character]) -> [IndexPath] {
      let startIndex = characters.count - newCharacters.count
      let endIndex = startIndex + newCharacters.count
      return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }

}

// MARK: - FeedViewToPresenterProtocol

extension FeedPresenter: FeedViewToPresenterProtocol {
    func viewDidLoad(on view: FeedPresenterToViewProtocol) {
        self.view = view
        self.view?.showLoader()
        interactor.fetchCharacters(offset: 0)
    }

    func searchCharacters(withName name: String, offset: Int) {
        self.offset = offset
        // For UICollectionView Infinite Scrolling,
        // We show the loading alert message just the first time.
        if offset == 0 {
            view?.showLoader()
        }
        interactor.searchCharacters(withName: name, offset: offset)
        view?.dismissKeyBoard()
    }

    func searchBarCancelButtonClicked() {
        view?.showLoader()
        interactor.fetchCharacters(offset: 0)
        view?.configureSearchBar(shouldShow: false)
    }

    // Route to DetailsView
    func didSelectCharacter(_ view: FeedPresenterToViewProtocol, character: Character) {
        guard let view = self.view else {
            assertionFailure("view should be available on Presenter")
            return
        }
        router.routeToDetailsView(view, character: character)
    }

    func handleShowSearchBar() {
        view?.configureSearchBar(shouldShow: true)
    }
}

// MARK: - FeedInteractorToPresenterProtocol

extension FeedPresenter: FeedInteractorToPresenterProtocol {

    func fetchCharactersWithSuccess(_ characters: [Character]) {
        view?.dismissLoader()
        if offset > 0 {
            self.characters.append(contentsOf: characters)
            let indexPathsToRelod = calculateIndexPathsToReload(from: characters)
            view?.fetchCharactersWithSuccess(characters, indexPathsToReload: indexPathsToRelod)
        } else {
            self.characters = characters
            view?.fetchCharactersWithSuccess(characters)
            view?.scrollToTop()
        }
    }

    func fetchCharactersWithFail(_ error: Error) {
        view?.dismissLoader()
        view?.fetchCharactersWithFail(error.localizedDescription)
    }
}
