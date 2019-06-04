//
//  Comment.swift
//  WBooks
//
//  Created by Gaston Maspero on 04/06/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation
import UIKit

struct Comment {
    
    var user: User
    
    var content: String
    
    var book: Book
    
    var id: Int
    
    init(user: User, content: String, book: Book, id: Int) {
        self.user = user
        self.content = content
        self.book = book
        self.id = id
    }
}

extension Comment: Codable {
    enum CommentKey: String, CodingKey {
        case user
        case content
        case book
        case id
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CommentKey.self)
        let user = try container.decode(User.self, forKey: .user)
        let content = try container.decode(String.self, forKey: .content)
        let book = try container.decode(Book.self, forKey: .book)
        let id = try container.decode(Int.self, forKey: .id)
        
        self.init(user: user, content: content, book: book, id: id)
    }
}
