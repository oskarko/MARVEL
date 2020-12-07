//
//  Extensions.swift
//  Marvel
//
//  Created by Oscar Rodriguez Garrucho on 2/12/20.
//  Copyright © 2020 Little Monster. All rights reserved.
//

import Foundation
import CryptoKit

extension String {

    /// Short form for calling NSLocalizedString method.
    func localized() -> String {
        NSLocalizedString(self, comment: "")
    }

    /// Calculate MD5 hash from a given String
    func MD5Hash() -> String {
        let digest = Insecure.MD5.hash(data: self.data(using: .utf8) ?? Data())

        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
}
