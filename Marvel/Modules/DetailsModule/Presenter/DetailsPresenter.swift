//
//  DetailsPresenter.swift
//  Marvel
//
//  Created by Oscar Rodriguez Garrucho on 9/12/20.
//  Copyright © 2020 Little Monster. All rights reserved.
//

import Foundation

class DetailsPresenter {
    
    // MARK: Properties

    weak var view: DetailsPresenterToViewProtocol?
    var interactor: DetailsPresenterToInteractorProtocol?
    var router: DetailsPresenterToRouteProtocol?

}

// MARK: - DetailsViewToPresenterProtocol

extension DetailsPresenter: DetailsViewToPresenterProtocol {
    // TODO: implement view to presenter methods
    func viewDidLoad() {
    }
}

// MARK: - DetailsInteractorToPresenterProtocol

extension DetailsPresenter: DetailsInteractorToPresenterProtocol {
    // TODO: implement interactor to presenter methods
}
