//
//  Rents.swift
//  WBooks
//
//  Created by Gaston Maspero on 03/06/2019.
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

enum RentError: Error {
    case decodeError
}

class RentsRepository: AbstractRepository {
    
    private static let rentPath = "/users/7/rents"
    
    func fetchRents() -> SignalProducer<[Rent], RepositoryError>{
        let path = RentsRepository.rentPath
        return performRequest(method: .get, path: path) { json in
            return decode(json).toResult()
        }
    }
    
    func rentBook(bookID: Int, from: String, to: String) -> SignalProducer<Void, RepositoryError> {
        let path = RentsRepository.rentPath
        let parameters = [
            "userID": 7,
            "bookID": bookID,
            "from": from,
            "to": to
            ] as [String: Any]
        
        return performRequest(method: .post, path: path, parameters: parameters) { _ in
            Result(value: ())
        }
    }
}
