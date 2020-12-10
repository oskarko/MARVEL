//
//  DetailsInteractor.swift
//  Marvel
//
//  Created by Oscar Rodriguez Garrucho on 9/12/20.
//  Copyright © 2020 Little Monster. All rights reserved.
//

import Foundation

class DetailsInteractor: DetailsPresenterToInteractorProtocol {

    // MARK: Properties

    weak var presenter: DetailsInteractorToPresenterProtocol?
    var localDatamanager: DetailsInteractorToLocalDataManagerProtocol?
    var remoteDatamanager: DetailsInteractorToRemoteDataManagerProtocol?

}

// MARK: DetailsRemoteDataManagerToInteractorProtocol

extension DetailsInteractor: DetailsRemoteDataManagerToInteractorProtocol {
    // TODO: Implement use case methods
}
