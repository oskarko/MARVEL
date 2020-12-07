//
//  MarvelData.swift
//  Marvel
//
//  Created by Oscar Rodriguez Garrucho on 7/12/20.
//  Copyright © 2020 Little Monster. All rights reserved.
//

import Foundation

struct MarvelData<T: Decodable>: Decodable {
    let data: MarvelResults<T>
}

struct MarvelResults<T: Decodable>: Decodable {
    let items: [T]

    enum CodingKeys: String, CodingKey {
        case items = "results"
    }
}
