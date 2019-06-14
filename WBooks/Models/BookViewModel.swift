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
    private var _book: Book
    
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
        var image: UIImage = UIImage.noProfilePic
        let url = URL(string: _book.image)
        if let url = url {
            do {
                let data = try Data(contentsOf: url)
                image = UIImage(data: data)!
            } catch {
                print("No image available for book \(_book.title)")
            }
        }
        return image
    }
    
    var status: String {
        get {
            return _book.status
        }
        set {
            _book.status = newValue
        }
    }
    
    init(book: Book) {
        _book = book
    }    
}
