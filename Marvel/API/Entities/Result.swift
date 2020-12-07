//
//  Result.swift
//  Marvel
//
//  Created by Oscar Rodriguez Garrucho on 7/12/20.
//  Copyright © 2020 Little Monster. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case fail(Error)
}
