//
//  DetailsView.swift
//  Marvel
//
//  Created by Oscar Rodriguez Garrucho on 9/12/20.
//  Copyright © 2020 Little Monster. All rights reserved.
//

import Foundation
import UIKit

class DetailsView: UIViewController {

    // MARK: Properties

    var presenter: DetailsViewToPresenterProtocol?

    var character: Character? {
        didSet {
            configure()
        }
    }

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: Helpers

    private func configureUI() {
        // TODO: setup UI programmatically
    }

    private func configure() {
        // TODO: setup UI programmatically
        guard let character = character else { return }

        print("DEBUG: \(character.name)")
    }
}

// MARK: DetailsPresenterToViewProtocol

extension DetailsView: DetailsPresenterToViewProtocol {
    // TODO: implement presenter to view methods
}
