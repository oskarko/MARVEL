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

    var offset: Int = 0

    func fetchCharacters(offset: Int) {
        self.offset = offset
        // call to our remoteService to get MARVEL characters.
        remoteDatamanager?.fetchCharacters(offset: offset)
    }

    func searchCharacters(withName name: String, offset: Int) {
        self.offset = offset
        if !name.isEmpty {
            // call to our remoteService to get MARVEL characters
            // with such as name contains this one.
            // Don't forget to replace spaces by "_" in order to get the API works fine.
            let strippedName = name.replacingOccurrences(of: " ", with: "_")
            remoteDatamanager?.searchCharacters(withName: strippedName, offset: offset)
        } else {
            remoteDatamanager?.fetchCharacters(offset: offset)
        }
    }

}

// MARK: FeedRemoteDataManagerToInteractorProtocol

extension FeedInteractor: FeedRemoteDataManagerToInteractorProtocol {
    func fetchCharactersWithSuccess(_ characters: [Character]) {
        // We got characters from MARVEL API successfully!
        presenter?.fetchCharactersWithSuccess(characters, append: offset > 0)
    }

    func fetchCharactersWithFail(_ error: Error) {
        // We got some errors while fetching characters from MARVEL API.
        presenter?.fetchCharactersWithFail(error)
    }
}
