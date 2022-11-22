//
//  User.swift
//  MoviesApp
//
//  Created by User on 09/11/22.
//

import Foundation
import SwiftyUserDefaults

struct User: DefaultsSerializable, Codable {
    var age: Int
}

extension User: Equatable {
}
