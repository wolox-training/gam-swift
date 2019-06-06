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

enum CommentError: Error {
    case decodeError
}

class CommentsRepository {
    static func fetchComments(onSuccess: @escaping ([Comment]) -> Void, onError: @escaping (Error) -> Void, bookID: Int) {
        let url = URL(string: "https://swift-training-backend.herokuapp.com/books/\(bookID)/comments")!
        request(url, method: .get).responseJSON { response in
            //Handle response
            //check if request was succesful
            switch response.result {
            case .success(let value):
                // request was successful
                //check if data is valid, if not call error function
                guard let JSONcomments = try? JSONSerialization.data(withJSONObject: value, options: []) else {
                    onError(CommentError.decodeError)
                    return
                }
                //check if data is valid, if not call error function
                guard let comments = try? JSONDecoder().decode([Comment].self, from: JSONcomments) else {
                    onError(CommentError.decodeError)
                    return
                }
                // request was successful and data is valid so we call success function
                onSuccess(comments)
            case .failure(let error):
                // request failed so we call the error function
                onError(error)
            }
        }
    }
}
