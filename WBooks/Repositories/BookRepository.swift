//
//  BookRepository.swift
//  WBooks
//
//  Created by Gaston Maspero on 30/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation
import Result
import Alamofire
import Networking
import ReactiveSwift
import ReactiveCocoa
import Curry
import Runes
import Argo

enum BookError: Error {
    case decodeError
}

class BookRepository: AbstractRepository {
    
    private static let bookPath = "/books"
    
    func fetchBooks() -> SignalProducer<[Book], RepositoryError> {
        let path = BookRepository.bookPath
        
        return performRequest(method: .get, path: path) { json in
            return decode(json).toResult()
        }
    }
    
    func addNewBook(book: Book) -> SignalProducer<Void, RepositoryError> {
        
        let path = BookRepository.bookPath
        let parameters = [
            "author": book.author,
            "title": book.title,
            "image": book.image,
            "year": book.year,
            "genre": book.genre,
            "status": book.status
            ] as [String: Any]
        
        return performRequest(method: .post, path: path, parameters: parameters) { _ in
            Result(value: ())
        }
    }
}
