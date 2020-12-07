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
        interactor?.fetchCharacters()
    }
}

// MARK: - FeedInteractorToPresenterProtocol

extension FeedPresenter: FeedInteractorToPresenterProtocol {

    func fetchCharactersWithSuccess(_ characters: [Character]) {
        view?.fetchCharactersWithSuccess(characters)
    }

    func fetchCharactersWithFail() {

    }
}
