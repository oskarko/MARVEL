//
//  RequestAdapter.swift
//  Marvel
//
//  Created by Oscar Rodriguez Garrucho on 7/12/20.
//  Copyright © 2020 Little Monster. All rights reserved.
//

import Foundation
import UIKit

class RequestAdapter {
    static func request<T: Decodable>(_ url: URL, _ onComplete: @escaping (Result<T>) -> Void) {

        let session = URLSession(configuration: URLSessionConfiguration.default)

        let task = session.dataTask(with: url) { (data, _, requestError) in

            if let requestError = requestError {
                return onComplete(.fail(requestError))
            }
            guard let data = data else { return }

            do {
                let response = try JSONDecoder().decode(T.self, from: data)
                onComplete(.success(response))
            } catch {
                onComplete(.fail(error))
            }
        }
        task.resume()
    }
}
