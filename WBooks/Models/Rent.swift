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
    let book: String
    let rentId: String
    let usr: String
    let to: String
    let from: String
    
    init(book: String, rentId: String, usr: String, to: String, from: String) {
        self.book = book
        self.rentId = rentId
        self.usr = usr
        self.to = to
        self.from = from
    }
}

extension Rent: Codable {
    enum RentKey: String, CodingKey {
        case book
        case rentId
        case usr
        case to
        case from
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RentKey.self)
        let book = try container.decode(String.self, forKey: .book)
        let rentId = try container.decode(String.self, forKey: .rentId)
        let usr = try container.decode(String.self, forKey: .usr)
        let to = try container.decode(String.self, forKey: .to)
        let from = try container.decode(String.self, forKey: .from)
        
        self.init(book: book, rentId: rentId, usr: usr, to: to, from: from)
    }
}
