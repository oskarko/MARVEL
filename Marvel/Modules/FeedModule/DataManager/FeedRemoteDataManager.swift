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
    var offset: Int = 0

    func fetchCharacters(offset: Int) {
        self.offset = offset
        // call to MARVEL API to get characters
        NetworkLayer().fetch(ofType: .characters(CHARACTERS_BY_PAGE, offset),
                             onComplete: updateCharacters)
    }

    private func updateCharacters(response: Result<MarvelData<Character>>) {
        switch response {
        case .success(let response):
            print("DEBUG: We got \(response.data.items.count) characters!")
            interactor?.fetchCharactersWithSuccess(response.data.items, append: offset > 0)
        case .fail(let error):
            print("DEBUG: Something went wrong. Error: \(error.localizedDescription)")
            interactor?.fetchCharactersWithFail(error)
        }
    }

    func searchCharacters(withName name: String, offset: Int) {
        self.offset = offset
        // call to MARVEL API to get characters with a given name
        NetworkLayer().fetch(ofType: .charactersByName(name, CHARACTERS_BY_PAGE, offset),
                             onComplete: updateCharacters)
    }
}
