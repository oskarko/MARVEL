//
//  FeedInteractor.swift
//  Marvel
//
//  Created by Oscar Rodriguez Garrucho on 7/12/20.
//  Copyright © 2020 Little Monster. All rights reserved.
//

import Foundation

class FeedInteractor: FeedPresenterToInteractorProtocol {

    // MARK: Properties

    weak var presenter: FeedInteractorToPresenterProtocol?
    var localDatamanager: FeedInteractorToLocalDataManagerProtocol?
    var remoteDatamanager: FeedInteractorToRemoteDataManagerProtocol?

    func fetchCharacters() {
        // call to our remoteService to get MARVEL characters.
        remoteDatamanager?.fetchCharacters()
    }

    func searchCharacter(withName name: String) {
        if !name.isEmpty {
            // call to our remoteService to get MARVEL characters
            // with such as name contains this one.
            // Don't forget to replace spaces by "_" in order to get the API works fine.
            let strippedName = name.replacingOccurrences(of: " ", with: "_")
            remoteDatamanager?.searchCharacter(withName: strippedName)
        } else {
            remoteDatamanager?.fetchCharacters()
        }
    }

}

// MARK: FeedRemoteDataManagerToInteractorProtocol

extension FeedInteractor: FeedRemoteDataManagerToInteractorProtocol {
    func fetchCharactersWithSuccess(_ characters: [Character]) {
        // We got characters from MARVEL API successfully!
        presenter?.fetchCharactersWithSuccess(characters)
    }

    func fetchCharactersWithFail() {
        // We got some errors while fetching characters from MARVEL API.
    }
}
