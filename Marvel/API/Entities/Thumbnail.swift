//
//  Thumbnail.swift
//  Marvel
//
//  Created by Oscar Rodriguez Garrucho on 7/12/20.
//  Copyright © 2020 Little Monster. All rights reserved.
//

import Foundation

struct Thumbnail: Decodable {
    let path: String?
    let fileExtension: Extension?

    enum CodingKeys: String, CodingKey {
        case path
        case fileExtension = "extension"
    }
}

enum Extension: String, Decodable {
    case gif = "gif"
    case jpg = "jpg"
    case png = "png"
}
