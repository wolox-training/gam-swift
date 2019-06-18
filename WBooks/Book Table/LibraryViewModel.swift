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

class LibraryViewModel: BookTableAbstractViewModel {
    
    var books = [BookViewModel]()
    
    var state = MutableProperty(TableState.loading)
    
    let bookRepository = RepositoryBuilder.getDefaultBookRepository()
    
    func loadBooks() {
        bookRepository.fetchBooks().startWithResult { [weak self] result in
            switch result {
            case .success(let resultArray):
                self?.setBooks(books: resultArray)
                self?.state.value = resultArray.isEmpty ? .empty : .withValues
            case .failure(let error):
                self?.state.value = .error
                print(error)
            }
        }
    }
    
    private func setBooks(books: [Book]) {
        self.books = books.map({ (book) in
            BookViewModel(book: book)
        })
    }
}
