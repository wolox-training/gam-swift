//
//  Suggestion.swift
//  WBooks
//
//  Created by Gaston Maspero on 13/06/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation
import UIKit
import Argo
import Networking
import WolmoCore
import Curry
import Runes

class Suggestion {
    let link: String
    let title: String
    let user: User
    let id: Int
    let author: String
    
    init(link: String, title: String, user: User, id: Int, author: String) {
        self.link = link
        self.title = title
        self.user = user
        self.id = id
        self.author = author
    }
}

extension Suggestion: Argo.Decodable {
    static func decode(_ json: JSON) -> Decoded<Suggestion> {
        return curry(Suggestion.init)
            <^> json <| "link"
            <*> json <| "title"
            <*> json <| "user"
            <*> json <| "id"
            <*> json <| "author"
    }
}
