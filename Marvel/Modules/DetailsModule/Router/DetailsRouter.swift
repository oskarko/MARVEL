//
//  DetailsRouter.swift
//  Marvel
//
//  Created by Oscar Rodriguez Garrucho on 9/12/20.
//  Copyright © 2020 Little Monster. All rights reserved.
//

import Foundation
import UIKit

class DetailsRouter: DetailsPresenterToRouteProtocol {
    
    class func createDetailsModule(navController: Bool, character: Character) -> UIViewController {
        let view = DetailsView()
        let presenter: DetailsViewToPresenterProtocol
            & DetailsInteractorToPresenterProtocol = DetailsPresenter()
        let interactor: DetailsPresenterToInteractorProtocol
            & DetailsRemoteDataManagerToInteractorProtocol = DetailsInteractor()
        let localDataManager: DetailsInteractorToLocalDataManagerProtocol = DetailsLocalDataManager()
        let remoteDataManager: DetailsInteractorToRemoteDataManagerProtocol = DetailsRemoteDataManager()
        let router: DetailsPresenterToRouteProtocol = DetailsRouter()

        view.presenter = presenter
        view.character = character
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.localDatamanager = localDataManager
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.interactor = interactor

        if navController {
            let navController = UINavigationController(rootViewController: view)
            navController.modalPresentationStyle = .fullScreen

            return navController
        }

        return view
    }

}
