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
        let parameters = ["user_id": "7"]
        let headers = ["Content-Type": "application/json", "Accept": "application/json"]
        let url = URL(string: "https://swift-training-backend.herokuapp.com/user/7/rents")!
        Alamofire.request(url, method: .get, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        request(url, method: .get).responseJSON { response in
            //Handle response
            //check if request was succesful
            switch response.result {
            case .success(let value):
                // request was successful
                print("SUCCESS ANGST")
                //check if data is valid, if not call error function
                guard let JSONrents = try? JSONSerialization.data(withJSONObject: value, options: []) else {
                    onError(RentError.decodeError)
                    return
                }
                //check if data is valid, if not call error function
                guard let rents = try? JSONDecoder().decode([Rent].self, from: JSONrents) else {
                    print("ERROR HERE")
                    onError(RentError.decodeError)
                    return
                }
                // request was successful and data is valid so we call success function
                onSuccess(rents)
            case .failure(let error):
                // request failed so we call the error function
                onError(error)
            }
        }
    }
}
