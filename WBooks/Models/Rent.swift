//
//  Rent.swift
//  WBooks
//
//  Created by Gaston Maspero on 03/06/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation
import UIKit
import Argo
import Networking
import WolmoCore
import Curry
import Runes

struct Rent {
    
    let id: Int
    let to: String
    let from: String
    let book: Book
    let user: User
    
    init(id: Int, to: String, from: String, book: Book, user: User) {
        self.id = id
        self.to = to
        self.from = from
        self.book = book
        self.user = user
    }
}

extension Rent: Argo.Decodable {
    static func decode(_ json: JSON) -> Decoded<Rent> {
        return curry(Rent.init)
            <^> json <| "id"
            <*> json <| "to"
            <*> json <| "from"
            <*> json <| "book"
            <*> json <| "user"
    }
}
