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
    func fetchCharactersWithFail()
    func configureSearchBar(shouldShow: Bool)
    func dismissKeyBoard()
}

protocol FeedPresenterToRouteProtocol: class {
    // Presenter -> Router
    static func createFeedModule(navController: Bool) -> UIViewController
}

protocol FeedViewToPresenterProtocol: class {
    // View -> Presenter
    var view: FeedPresenterToViewProtocol? { get set }
    var interactor: FeedPresenterToInteractorProtocol? { get set }
    var router: FeedPresenterToRouteProtocol? { get set }

    func viewDidLoad()
    func searchCharacter(withName name: String)
    func searchBarCancelButtonClicked()
    func handleShowSearchBar()
}

protocol FeedInteractorToPresenterProtocol: class {
    // Interactor -> Presenter
    func fetchCharactersWithSuccess(_ characters: [Character])
    func fetchCharactersWithFail()
}

protocol FeedPresenterToInteractorProtocol: class {
    // Presenter -> Interactor
    var presenter: FeedInteractorToPresenterProtocol? { get set }
    var localDatamanager: FeedInteractorToLocalDataManagerProtocol? { get set }
    var remoteDatamanager: FeedInteractorToRemoteDataManagerProtocol? { get set }

    func fetchCharacters()
    func searchCharacter(withName name: String)
}

protocol FeedInteractorToDataManagerProtocol: class {
    // Interactor -> DataManager
}

protocol FeedInteractorToRemoteDataManagerProtocol: class {
    // Interactor -> RemoteDataManager
    var interactor: FeedRemoteDataManagerToInteractorProtocol? { get set }

    func fetchCharacters()
    func searchCharacter(withName name: String)
}

protocol FeedRemoteDataManagerToInteractorProtocol: class {
    // RemoteDataManager -> Interactor

    func fetchCharactersWithSuccess(_ characters: [Character])
    func fetchCharactersWithFail()
}

protocol FeedInteractorToLocalDataManagerProtocol: class {
    // Interactor -> LocalDataManager
}
