//
//  SuggestionsViewModel.swift
//  WBooks
//
//  Created by Gaston Maspero on 13/06/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation
import ReactiveSwift
import UIKit

class SuggestionsViewModel {
    
    let booksRepository = RepositoryBuilder.getDefaultBookRepository()
    let state = MutableProperty(TableState.loading)
    
    var suggestedBooks = [BookViewModel]()
    
    func loadSuggestions() {
        booksRepository.fetchBooks().startWithResult { [weak self] result in
            switch result {
            case .success(let resultArray):
                self?.setBooks(books: resultArray)
                self?.filterMissingCovers()
                self?.state.value = resultArray.isEmpty ? .empty : .withValues
            case .failure(let error):
                self?.state.value = .error
                print(error)
            }
        }
    }
    
    private func setBooks(books: [Book]) {
        suggestedBooks = books.map({ (book) in
            BookViewModel(book: book)
        })
    }
    
    private func filterMissingCovers() {
        suggestedBooks = suggestedBooks.filter { bookViewModel in
            return bookViewModel.cover != UIImage.noProfilePic
        }
    }
}
