//
//  Book.swift
//  WBooks
//
//  Created by Gaston Maspero on 22/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation
import UIKit

class Book {
    var title: String
    var author: String
    var cover: UIImage
    
    init(title: String, author: String, cover: UIImage){
        self.title = title
        self.author = author
        self.cover = cover
    }
}
