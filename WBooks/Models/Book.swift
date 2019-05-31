//
//  Book.swift
//  WBooks
//
//  Created by Gaston Maspero on 22/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation
import UIKit

struct Book {
    let title: String
    let author: String
    let id: Int
    let genre: String
    let year: String
    let image: String
    
    init(title: String, author: String, id: Int, genre: String, year: String, image: String) {
        self.title = title
        self.author = author
        self.id = id
        self.genre = genre
        self.year = year
        self.image = image
    }
}

extension Book: Codable {
    enum BookKey: String, CodingKey {
        case id
        case title
        case author
        case genre
        case year
        case image
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: BookKey.self)
        let id = try container.decode(Int.self, forKey: .id)
        let title = try container.decode(String.self, forKey: .title)
        let author = try container.decode(String.self, forKey: .author)
        let genre = try container.decode(String.self, forKey: .genre)
        let year = try container.decode(String.self, forKey: .year)
        let image = try container.decode(String.self, forKey: .image)
        
        self.init(title: title, author: author, id: id, genre: genre, year: year, image: image)
    }
}
