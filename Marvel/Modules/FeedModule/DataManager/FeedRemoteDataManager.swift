//
//  FeedRemoteDataManager.swift
//  Marvel
//
//  Created by Oscar Rodriguez Garrucho on 7/12/20.
//  Copyright © 2020 Little Monster. All rights reserved.
//

import Foundation

class FeedRemoteDataManager:FeedInteractorToRemoteDataManagerProtocol {

    // MARK: Properties

    var interactor: FeedRemoteDataManagerToInteractorProtocol?

    func fetchCharacters() {
        // call to MARVEL API to get characters()
        NetworkLayer().fetch(ofType: .characters(40, 0), onComplete: updateCharacters)
    }

    private func updateCharacters(response: Result<MarvelData<Character>>) {
        switch response {
        case .success(let response):
            print("DEBUG: We got \(response.data.items.count) characters!")
            interactor?.fetchCharactersWithSuccess(response.data.items)
        case .fail(let error):
            print("DEBUG: Something went wrong. Error: \(error.localizedDescription)")
            interactor?.fetchCharactersWithFail(error)
        }
    }

    func searchCharacter(withName name: String) {
        NetworkLayer().fetch(ofType: .charactersByName(name, 40, 0), onComplete: updateCharacters)
    }
}
