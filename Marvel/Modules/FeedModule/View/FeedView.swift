//
//  FeedView.swift
//  Marvel
//
//  Created by Oscar Rodriguez Garrucho on 7/12/20.
//  Copyright © 2020 Little Monster. All rights reserved.
//

import Foundation
import UIKit

class FeedView: UIViewController {

    // MARK: Properties

    var presenter: FeedViewToPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        presenter?.viewDidLoad()
    }

    // MARK: Helpers

    private func configureUI() {
        // TODO: setup UI programmatically
    }
}

// MARK: FeedPresenterToViewProtocol

extension FeedView: FeedPresenterToViewProtocol {
    func fetchCharactersWithSuccess(_ characters: [Character]) {

    }

    func fetchCharactersWithFail() {

    }
}
