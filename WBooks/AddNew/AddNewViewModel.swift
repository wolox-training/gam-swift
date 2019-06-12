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

class AddNewViewModel {
    
    let bookName = MutableProperty("")
    let author = MutableProperty("")
    let year = MutableProperty("")
    let genre = MutableProperty("")
    let descrpition = MutableProperty("")
    
    private var book: Book {
        return Book(title: bookName.value, author: author.value, id: 0, genre: genre.value, year: year.value, image: "some url", status: "available")
    }
    
    func addBook(onSuccess: @escaping () -> Void, onError: @escaping (Error) -> Void) {
        BookRepository.addNewBook(book: book, onSuccess: onSuccess, onError: onError)
    }
}
