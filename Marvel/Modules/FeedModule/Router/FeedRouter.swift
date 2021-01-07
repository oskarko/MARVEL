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

    func createFeedModule(navController: Bool) -> UIViewController {

        let localDataManager = FeedLocalDataManager()
        let remoteDataManager = FeedRemoteDataManager()
        let interactor = FeedInteractor(localDatamanager: localDataManager,
                                        remoteDatamanager: remoteDataManager)
        let presenter = FeedPresenter(interactor: interactor, router: self)
        let view = FeedView(presenter: presenter, collectionViewLayout: UICollectionViewFlowLayout())

        // weak references
        interactor.presenter = presenter
        localDataManager.interactor = interactor
        remoteDataManager.interactor = interactor

        if navController {
            let navController = UINavigationController(rootViewController: view)
            navController.modalPresentationStyle = .fullScreen

            return navController
        }

        return view
    }

    func routeToDetailsView(_ view: FeedPresenterToViewProtocol, character: Character) {
        if let view = view as? FeedView {
            let details = DetailsRouter.createDetailsModule(navController: false,
                                                            character: character)
            view.navigationController?.pushViewController(details, animated: true)
        }
    }

}
