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
    
    var menuController: MainMenuController?
    
    init() {
        BookRepository.fetchBooks(onSuccess: onSuccess, onError: onError)
    }
    
    func onSuccess(books: [Book]) {
        setBooks(books: books)
        menuController!.updateTableView()
        print(books)
    }
    
    let onError = { error in
        print(error)
    }
    
    private func setBooks(books: [Book]) {
        self.books = books.map({ (book) in
            BookViewModel(book: book)
        })
    }
}