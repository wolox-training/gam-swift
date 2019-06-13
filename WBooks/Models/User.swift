//
//  User.swift
//  WBooks
//
//  Created by Gaston Maspero on 04/06/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation
import UIKit
import Argo
import Networking
import WolmoCore
import Curry
import Runes

struct User {
    let id: Int
    let image: String?
    let username: String
    
    init(id: Int, image: String?, username: String) {
        self.id = id
        self.image = image
        self.username = username
    }
}

extension User: Argo.Decodable {
    static func decode(_ json: JSON) -> Decoded<User> {
        return curry(User.init)
            <^> json <| "id"
            <*> json <|? "image"
            <*> json <| "username"
    }
}
