//
//  MainMenuViewModel.swift
//  WBooks
//
//  Created by Gaston Maspero on 28/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation
import UIKit

class MainMenuViewModel {
    
    var books: [BookViewModel] = []
    
    var table: UITableView?
    
    func loadBooks(onSuccess: @escaping ([Book]) -> Void) {
        BookRepository.fetchBooks(onSuccess: onSuccess, onError: onError)
    }
    
    func onSuccess(books: [Book]) {
        setBooks(books: books)
    }
    
    func onError(error: Error) {
        return
    }
    
    private func setBooks(books: [Book]) {
        self.books = books.map({ (book) in
            BookViewModel(book: book)
        })
    }
}
