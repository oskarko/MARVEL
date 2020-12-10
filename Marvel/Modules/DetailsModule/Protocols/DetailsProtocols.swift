//
//  DetailsProtocols.swift
//  Marvel
//
//  Created by Oscar Rodriguez Garrucho on 9/12/20.
//  Copyright © 2020 Little Monster. All rights reserved.
//

import Foundation
import UIKit

protocol DetailsPresenterToViewProtocol: class {
    // Presenter -> View
    var presenter: DetailsViewToPresenterProtocol? { get set }
}

protocol DetailsPresenterToRouteProtocol: class {
    // Presenter -> Router
    static func createDetailsModule(navController: Bool, character: Character) -> UIViewController
}

protocol DetailsViewToPresenterProtocol: class {
    // View -> Presenter
    var view: DetailsPresenterToViewProtocol? { get set }
    var interactor: DetailsPresenterToInteractorProtocol? { get set }
    var router: DetailsPresenterToRouteProtocol? { get set }

    func viewDidLoad()
}

protocol DetailsInteractorToPresenterProtocol: class {
    // Interactor -> Presenter
}

protocol DetailsPresenterToInteractorProtocol: class {
    // Presenter -> Interactor
    var presenter: DetailsInteractorToPresenterProtocol? { get set }
    var localDatamanager: DetailsInteractorToLocalDataManagerProtocol? { get set }
    var remoteDatamanager: DetailsInteractorToRemoteDataManagerProtocol? { get set }
}

protocol DetailsInteractorToDataManagerProtocol: class {
    // Interactor -> DataManager
}

protocol DetailsInteractorToRemoteDataManagerProtocol: class {
    // Interactor -> RemoteDataManager
    var interactor: DetailsRemoteDataManagerToInteractorProtocol? { get set }
}

protocol DetailsRemoteDataManagerToInteractorProtocol: class {
    // RemoteDataManager -> Interactor
}

protocol DetailsInteractorToLocalDataManagerProtocol: class {
    // Interactor -> LocalDataManager
}
