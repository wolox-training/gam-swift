//
//  User.swift
//  WBooks
//
//  Created by Gaston Maspero on 04/06/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation

struct User: Codable {
    let id: Int
    let image: String?
    let username: String
    
    init(id: Int, image: String, username: String) {
        self.id = id
        self.image = image
        self.username = username
    }
}
