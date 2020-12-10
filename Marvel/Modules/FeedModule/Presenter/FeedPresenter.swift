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
    var interactor: FeedPresenterToInteractorProtocol?
    var router: FeedPresenterToRouteProtocol?

}

// MARK: - FeedViewToPresenterProtocol

extension FeedPresenter: FeedViewToPresenterProtocol {
    func viewDidLoad() {
        view?.showLoader()
        interactor?.fetchCharacters(offset: 0)
    }

    func searchCharacters(withName name: String, offset: Int) {
        // For UICollectionView Infinite Scrolling,
        // We show the loading alert message just the first time.
        if offset == 0 {
            view?.showLoader()
        }
        interactor?.searchCharacters(withName: name, offset: offset)
        view?.dismissKeyBoard()
    }

    func searchBarCancelButtonClicked() {
        view?.showLoader()
        interactor?.fetchCharacters(offset: 0)
        view?.configureSearchBar(shouldShow: false)
    }

    // Route to DetailsView
    func didSelectCharacter(_ view: FeedPresenterToViewProtocol, character: Character) {
        router?.routeToDetailsView(view, character: character)
    }

    func handleShowSearchBar() {
        view?.configureSearchBar(shouldShow: true)
    }
}

// MARK: - FeedInteractorToPresenterProtocol

extension FeedPresenter: FeedInteractorToPresenterProtocol {

    func fetchCharactersWithSuccess(_ characters: [Character], append: Bool) {
        view?.dismissLoader()
        view?.fetchCharactersWithSuccess(characters, append: append)
        if !append {
            view?.scrollToTop()
        }
    }

    func fetchCharactersWithFail(_ error: Error) {
        view?.dismissLoader()
        view?.fetchCharactersWithFail(error.localizedDescription)
    }
}
