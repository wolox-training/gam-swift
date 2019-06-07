//
//  MainMenuViewModel.swift
//  WBooks
//
//  Created by Gaston Maspero on 28/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation
import UIKit
import ReactiveCocoa
import ReactiveSwift

class MainMenuViewModel {
    
    var books = MutableProperty<[BookViewModel]>([])
    
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
        self.books.value = books.map({ (book) in
            BookViewModel(book: book)
        })
    }
}
