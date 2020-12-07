//
//  Character.swift
//  Marvel
//
//  Created by Oscar Rodriguez Garrucho on 7/12/20.
//  Copyright © 2020 Little Monster. All rights reserved.
//

import Foundation

struct Character: Decodable {
    let id: Int
    let digitalID: Int?
    let name: String?
    let description: String?
    let title: String?
    let thumbnail: Thumbnail?

    enum CodingKeys: String, CodingKey {
        case digitalID = "digitalId"
        case description
        case id
        case name
        case title
        case thumbnail
    }
}
