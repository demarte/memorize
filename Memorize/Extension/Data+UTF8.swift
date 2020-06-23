//
//  Data+UTF8.swift
//  Memorize
//
//  Created by Ivan on 23/06/20.
//  Copyright © 2020 Ivan. All rights reserved.
//

import Foundation

extension Data {
    var utf8: String? { String(data: self, encoding: .utf8 ) }
}
