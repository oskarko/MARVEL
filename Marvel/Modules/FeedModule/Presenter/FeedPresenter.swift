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
        interactor?.fetchCharacters()
    }

    func searchCharacter(withName name: String) {
        view?.showLoader()
        interactor?.searchCharacter(withName: name)
        view?.dismissKeyBoard()
    }

    func searchBarCancelButtonClicked() {
        view?.showLoader()
        interactor?.fetchCharacters()
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

    func fetchCharactersWithSuccess(_ characters: [Character]) {
        view?.dismissLoader()
        view?.fetchCharactersWithSuccess(characters)
    }

    func fetchCharactersWithFail(_ error: Error) {
        view?.dismissLoader()
        view?.fetchCharactersWithFail(error.localizedDescription)
    }
}
