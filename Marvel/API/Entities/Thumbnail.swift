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
    case gif
    case jpg
    case png

    var description: String {
        switch self {
        case .gif: return "gif"
        case .jpg: return "jpg"
        case .png: return "png"
        }
    }
}
