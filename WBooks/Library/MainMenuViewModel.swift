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
    
    let userId: Int
    
    init(id: Int) {
        userId = id
    }
    
    var table: UITableView?
    
    func loadBooks(onSuccess: @escaping ([Book]) -> Void) {
        BookRepository.fetchBooks(onSuccess: onSuccess, onError: onError)
        RentsRepository.fetchRents(onSuccess: onSuccessRents, onError: onError)
    }
    
    func onSuccess(books: [Book]) {
        print(books)
        setBooks(books: books)
    }
    
    func onSuccessRents(rents: [Rent]) {
        print(rents)
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
