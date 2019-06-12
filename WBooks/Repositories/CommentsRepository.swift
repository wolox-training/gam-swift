//
//  CommentsRepository.swift
//  WBooks
//
//  Created by Gaston Maspero on 04/06/2019.
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

enum CommentError: Error {
    case decodeError
}

class CommentsRepository: AbstractRepository {
    
    func fetchComments(bookID: Int) -> SignalProducer<[Comment], RepositoryError> {
        let path = "/books/\(bookID)/comments"
        return performRequest(method: .get, path: path) { json in
            return decode(json).toResult()
        }
    }
}
