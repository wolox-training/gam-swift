//
//  BookViewModel.swift
//  WBooks
//
//  Created by Gaston Maspero on 28/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation
import UIKit

class BookViewModel {
    private let _book: Book
    
    var title: String {
        return _book.title
    }
    
    var author: String {
        return _book.author
    }
    
    var id: Int {
        return _book.id
    }
    
    var genre: String {
        return _book.genre
    }
    
    var year: String {
        return _book.year
    }
    
    var image: String {
        return _book.image
    }
    
    var cover: UIImage {
        return UIImage.addNewImage
    }
    
    init(book: Book) {
        _book = book
    }    
}
