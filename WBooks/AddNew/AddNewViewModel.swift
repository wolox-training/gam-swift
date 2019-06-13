//
//  AddNewViewModel.swift
//  WBooks
//
//  Created by Gaston Maspero on 07/06/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation
import ReactiveCocoa
import ReactiveSwift

enum AddBookState {
    case addSuccess
    case addError
    case sleep
}

class AddNewViewModel {
    
    let bookName = MutableProperty("")
    let author = MutableProperty("")
    let year = MutableProperty("")
    let genre = MutableProperty("")
    let descrpition = MutableProperty("")
    
    let bookRepository = RepositoryBuilder.getDefaultBookRepository()
    
    let addState = MutableProperty(AddBookState.sleep)
    
    private var book: Book {
        return Book(id: 0, title: bookName.value, author: author.value, genre: genre.value, year: year.value, image: "some url", status: "available")
    }
    
    func addBook() {
        bookRepository.addNewBook(book: book).startWithResult { [weak self] result in
            guard let this = self else {
                return
            }
            switch result {
            case .success:
                this.addState.value = .addSuccess
            case .failure(let error):
                // Here you can use error if you need it
                this.addState.value = .addError
                print(error)
            }
        }
    }
}
