//
//  Rent.swift
//  WBooks
//
//  Created by Gaston Maspero on 03/06/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation
import UIKit

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

extension Rent: Codable {
    enum RentKey: String, CodingKey {
        case id
        case to
        case from
        case book
        case user
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RentKey.self)
        let id = try container.decode(Int.self, forKey: .id)
        let to = try container.decode(String.self, forKey: .to)
        let from = try container.decode(String.self, forKey: .from)
        let book = try container.decode(Book.self, forKey: .book)
        let user = try container.decode(User.self, forKey: .user)
        
        self.init(id: id, to: to, from: from, book: book, user: user)
    }
}
