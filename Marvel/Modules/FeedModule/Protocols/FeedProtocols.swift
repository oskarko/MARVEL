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
    var presenter: FeedViewToPresenterProtocol? { get set }

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
    static func createFeedModule(navController: Bool) -> UIViewController

    func routeToDetailsView(_ view: FeedPresenterToViewProtocol, character: Character)
}

protocol FeedViewToPresenterProtocol: class {
    // View -> Presenter
    var view: FeedPresenterToViewProtocol? { get set }
    var interactor: FeedPresenterToInteractorProtocol? { get set }
    var router: FeedPresenterToRouteProtocol? { get set }

    func viewDidLoad()
    func searchCharacters(withName name: String, offset: Int)
    func searchBarCancelButtonClicked()
    func handleShowSearchBar()

    func didSelectCharacter(_ view: FeedPresenterToViewProtocol, character: Character)
}

protocol FeedInteractorToPresenterProtocol: class {
    // Interactor -> Presenter
    func fetchCharactersWithSuccess(_ characters: [Character], append: Bool)
    func fetchCharactersWithFail(_ error: Error)
}

protocol FeedPresenterToInteractorProtocol: class {
    // Presenter -> Interactor
    var presenter: FeedInteractorToPresenterProtocol? { get set }
    var localDatamanager: FeedInteractorToLocalDataManagerProtocol? { get set }
    var remoteDatamanager: FeedInteractorToRemoteDataManagerProtocol? { get set }

    func fetchCharacters(offset: Int)
    func searchCharacters(withName name: String, offset: Int)
}

protocol FeedInteractorToDataManagerProtocol: class {
    // Interactor -> DataManager
}

protocol FeedInteractorToRemoteDataManagerProtocol: class {
    // Interactor -> RemoteDataManager
    var interactor: FeedRemoteDataManagerToInteractorProtocol? { get set }

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
