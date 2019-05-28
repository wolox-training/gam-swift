//
//  MainMenuViewModel.swift
//  WBooks
//
//  Created by Gaston Maspero on 28/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation

class MainMenuViewModel {
    
    var books: [BookViewModel] = []
    
    init() {
        books = createArray()
    }
    
    private func createArray() -> [BookViewModel] {
        var books: [Book] = []
        books.append(Book(title: "A little bird told me", author: "Timothy Cross", cover: #imageLiteral(resourceName: "img_book1")))
        books.append(Book(title: "When the doves disappeared", author: "Sofi Oksanen", cover: #imageLiteral(resourceName: "img_book2")))
        books.append(Book(title: "The best book in the world", author: "Peter Stjernstrom", cover: #imageLiteral(resourceName: "img_book3")))
        books.append(Book(title: "Be creative", author: "Unknown", cover: #imageLiteral(resourceName: "img_book4")))
        books.append(Book(title: "Redesign the web", author: "Many", cover: #imageLiteral(resourceName: "img_book5")))
        books.append(Book(title: "The yellow book", author: "Wolox Wolox", cover: #imageLiteral(resourceName: "img_book6")))
        
        return books.map({ (book) in
            BookViewModel(book: book)
        })
    }
}
