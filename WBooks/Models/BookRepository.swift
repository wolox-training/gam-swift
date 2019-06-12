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

enum BookError: Error {
    case decodeError
}

class BookRepository {
    static func fetchBooks(onSuccess: @escaping ([Book]) -> Void, onError: @escaping (Error) -> Void) {
        let url = URL(string: "https://swift-training-backend.herokuapp.com/books")!
        request(url, method: .get).responseJSON { response in
            //Handle response
            //check if request was succesful
            switch response.result {
            case .success(let value):
                // request was successful
                //check if data is valid, if not call error function
                guard let JSONbooks = try? JSONSerialization.data(withJSONObject: value, options: []) else {
                    onError(BookError.decodeError)
                    return
                }
                //check if data is valid, if not call error function
                guard let books = try? JSONDecoder().decode([Book].self, from: JSONbooks) else {
                    onError(BookError.decodeError)
                    return
                }
                // request was successful and data is valid so we call success function
                onSuccess(books)
            case .failure(let error):
                // request failed so we call the error function
                onError(error)
            }
        }
    }
    
    static func addNewBook(book: Book, onSuccess: @escaping () -> Void, onError: @escaping (Error) -> Void) {
        let url = URL(string: "https://swift-training-backend.herokuapp.com/books")!
        
        let parameters = [
            "author": book.author,
            "title": book.title,
            "image": "some url",
            "year": book.year,
            "genre": book.genre,
            "status": "available"
        ] as [String: Any]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            switch response.result {
            case .success(let value):
                print(value)
                onSuccess()
            case .failure(let error):
                onError(error)
                print(error)
            }
        }
    }
}
