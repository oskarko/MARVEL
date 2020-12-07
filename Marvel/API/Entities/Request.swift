//
//  Request.swift
//  Marvel
//
//  Created by Oscar Rodriguez Garrucho on 7/12/20.
//  Copyright © 2020 Little Monster. All rights reserved.
//

import Foundation

enum Request {
    case character(Int)
    case characters(Int, Int)
    case charactersByName(String, Int, Int)
    case comics(Int)
    case series(Int)
}
