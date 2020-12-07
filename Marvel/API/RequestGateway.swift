//
//  RequestGateway.swift
//  Marvel
//
//  Created by Oscar Rodriguez Garrucho on 7/12/20.
//  Copyright © 2020 Little Monster. All rights reserved.
//

import Foundation

protocol RequestsGateway {
    func fetch<T: Decodable>(ofType: Request, onComplete: @escaping (Result<T>) -> Void)
}
