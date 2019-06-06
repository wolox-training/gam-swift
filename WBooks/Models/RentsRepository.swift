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

enum RentError: Error {
    case decodeError
}

class RentsRepository {
    static func fetchRents(onSuccess: @escaping ([Rent]) -> Void, onError: @escaping (Error) -> Void) {
        let url = URL(string: "https://swift-training-backend.herokuapp.com/users/7/rents")!
        request(url, method: .get).responseJSON { response in
            switch response.result {
            case .success(let value):
                guard let JSONrents = try? JSONSerialization.data(withJSONObject: value, options: []) else {
                    onError(RentError.decodeError)
                    return
                }
                guard let rents = try? JSONDecoder().decode([Rent].self, from: JSONrents) else {
                    onError(RentError.decodeError)
                    return
                }
                onSuccess(rents)
            case .failure(let error):
                onError(error)
            }
        }
    }
    
    static func rentBook(onSuccess: @escaping () -> Void, onError: @escaping () -> Void, bookID: Int, from: String, to: String) {
        let url = URL(string: "https://swift-training-backend.herokuapp.com/users/7/rents")!
        let parameters = [
            "userID": 7,
            "bookID": bookID,
            "from": from,
            "to": to
            ] as [String: Any]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            switch response.result {
            case .success(let value):
                onSuccess()
            case .failure(let error):
                onError()
                print(error)
            }
            
        }
    }
}
