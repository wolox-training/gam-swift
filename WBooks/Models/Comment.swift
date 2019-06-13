//
//  Comment.swift
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

extension Comment: Argo.Decodable {
    static func decode(_ json: JSON) -> Decoded<Comment> {
        return curry(Comment.init)
            <^> json <| "user"
            <*> json <| "content"
            <*> json <| "book"
            <*> json <| "id"
    }
}
