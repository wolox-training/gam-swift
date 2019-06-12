//
//  Book.swift
//  WBooks
//
//  Created by Gaston Maspero on 22/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation
import UIKit
import Argo
import Networking
import WolmoCore
import Curry
import Runes

struct Book {
    let id: Int
    let title: String
    let author: String
    let genre: String
    let year: String
    let image: String
    var status: String
    
    init(id: Int, title: String, author: String, genre: String, year: String, image: String, status: String) {
        self.id = id
        self.title = title
        self.author = author
        self.genre = genre
        self.year = year
        self.image = image
        self.status = status
    }
}

extension Book: Argo.Decodable {
    static func decode(_ json: JSON) -> Decoded<Book> {
        return curry(Book.init)
            <^> json <| "id"
            <*> json <| "title"
            <*> json <| "author"
            <*> json <| "genre"
            <*> json <| "year"
            <*> json <| "image"
            <*> json <| "status"
    }
}
