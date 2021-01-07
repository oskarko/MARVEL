//
//  FeedProtocols.swift
//  Marvel
//
//  Created by Oscar Rodriguez Garrucho on 7/12/20.
//  Copyright © 2020 Little Monster. All rights reserved.
//

import Foundation
import UIKit

protocol FeedPresenterToViewProtocol: class {
    // Presenter -> View
    func fetchCharactersWithSuccess(_ characters: [Character])
    func fetchCharactersWithSuccess(_ characters: [Character], indexPathsToReload: [IndexPath])
    func fetchCharactersWithFail(_ error: String)
    func configureSearchBar(shouldShow: Bool)
    func scrollToTop()
    func dismissKeyBoard()
    func showLoader()
    func dismissLoader()
}

protocol FeedPresenterToRouteProtocol: class {
    // Presenter -> Router
    func createFeedModule(navController: Bool) -> UIViewController
    func routeToDetailsView(_ view: FeedPresenterToViewProtocol, character: Character)
}

protocol FeedViewToPresenterProtocol: class {
    // View -> Presenter
    func viewDidLoad(on view: FeedPresenterToViewProtocol)
    func searchCharacters(withName name: String, offset: Int)
    func searchBarCancelButtonClicked()
    func handleShowSearchBar()
    func didSelectCharacter(_ view: FeedPresenterToViewProtocol, character: Character)
}

protocol FeedInteractorToPresenterProtocol: class {
    // Interactor -> Presenter
    func fetchCharactersWithSuccess(_ characters: [Character])
    func fetchCharactersWithFail(_ error: Error)
}

protocol FeedPresenterToInteractorProtocol: class {
    // Presenter -> Interactor
    func fetchCharacters(offset: Int)
    func searchCharacters(withName name: String, offset: Int)
}

protocol FeedInteractorToRemoteDataManagerProtocol: class {
    // Interactor -> RemoteDataManager
    func fetchCharacters(offset: Int)
    func searchCharacters(withName name: String, offset: Int)
}

protocol FeedRemoteDataManagerToInteractorProtocol: class {
    // RemoteDataManager -> Interactor
    func fetchCharactersWithSuccess(_ characters: [Character])
    func fetchCharactersWithFail(_ error: Error)
}

protocol FeedInteractorToLocalDataManagerProtocol: class {
    // Interactor -> LocalDataManager
}

protocol FeedLocalDataManagerToInteractorProtocol: class {
    // LocalDataManager -> Interactor
}
