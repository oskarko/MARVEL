//
//  Extensions.swift
//  Marvel
//
//  Created by Oscar Rodriguez Garrucho on 2/12/20.
//  Copyright © 2020 Little Monster. All rights reserved.
//

import Foundation

extension String {

    /// Short form for calling NSLocalizedString method.
    func localized() -> String {
        NSLocalizedString(self, comment: "")
    }
}
