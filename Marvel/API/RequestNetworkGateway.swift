//
//  RequestNetworkGateway.swift
//  Marvel
//
//  Created by Oscar Rodriguez Garrucho on 7/12/20.
//  Copyright © 2020 Little Monster. All rights reserved.
//

import Foundation

struct RequestsNetworkGateway: RequestsGateway {

    var hash: String {
        let combined = "\(TIMESTAMP)\(PRIVATE_KEY)\(PUBLIC_KEY)"
        let md5Hex =  combined.MD5Hash()

        return md5Hex
    }

    func fetch<T: Decodable>(ofType: Request, onComplete: @escaping (Result<T>) -> Void) {
        switch ofType {
        case .charactersByName(let name, let limit, let offset):
            guard let requestURL = URL(string: BASE_URL + "characters?orderBy=name&limit=" +
                                        "\(limit)&offset=\(offset)&apikey=\(PUBLIC_KEY)&hash=\(hash)&ts=" +
                                        "\(TIMESTAMP)&nameStartsWith=\(name)") else { return }

            RequestAdapter.request(requestURL, onComplete)

        case .characters(let limit, let offset):
            guard let requestURL = URL(string: BASE_URL + "characters?orderBy=name&limit=" +
                                        "\(limit)&offset=\(offset)&apikey=\(PUBLIC_KEY)&hash=\(hash)&ts=" +
                                        "\(TIMESTAMP)") else { return }

            RequestAdapter.request(requestURL, onComplete)

        case .character(let id):
            guard let requestURL = URL(string: BASE_URL + "characters/\(id)?apikey=" +
                                        "\(PUBLIC_KEY)&hash=\(hash)&ts=\(TIMESTAMP)") else { return }

            RequestAdapter.request(requestURL, onComplete)

        case .comics(let id):
            guard let requestURL = URL(string: BASE_URL + "characters/\(id)/comics?apikey=" +
                                        "\(PUBLIC_KEY)&hash=\(hash)&ts=\(TIMESTAMP)") else { return }

            RequestAdapter.request(requestURL, onComplete)

        case .series(let id):
            guard let requestURL = URL(string: BASE_URL + "characters/\(id)/series?apikey=" +
                                        "\(PUBLIC_KEY)&hash=\(hash)&ts=\(TIMESTAMP)") else { return }

            RequestAdapter.request(requestURL, onComplete)
        }
    }
}
