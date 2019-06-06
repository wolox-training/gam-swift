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
    
    let user: User
    let content: String
    let book: Book
    let id: Int
    
    var profilePic: UIImage {
        var image: UIImage = UIImage.noProfilePic
        if let profilePic = user.image {
            let url = URL(string: profilePic)
            if let url = url {
                do {
                    let data = try Data(contentsOf: url)
                    image = UIImage(data: data)!
                } catch {
                    print("No image available for user \(user.id)")
                }
            }
        }
        return image
    }
    
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
