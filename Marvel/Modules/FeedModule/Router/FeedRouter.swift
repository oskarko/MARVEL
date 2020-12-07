//
//  FeedRouter.swift
//  Marvel
//
//  Created by Oscar Rodriguez Garrucho on 7/12/20.
//  Copyright © 2020 Little Monster. All rights reserved.
//

import Foundation
import UIKit

class FeedRouter: FeedPresenterToRouteProtocol {

    class func createFeedModule(navController: Bool) -> UIViewController {
        let view = FeedView(collectionViewLayout: UICollectionViewFlowLayout())
        let presenter: FeedViewToPresenterProtocol & FeedInteractorToPresenterProtocol = FeedPresenter()
        let interactor: FeedPresenterToInteractorProtocol
            & FeedRemoteDataManagerToInteractorProtocol = FeedInteractor()
        let localDataManager: FeedInteractorToLocalDataManagerProtocol = FeedLocalDataManager()
        let remoteDataManager: FeedInteractorToRemoteDataManagerProtocol = FeedRemoteDataManager()
        let router: FeedPresenterToRouteProtocol = FeedRouter()

        view.presenter = presenter
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
