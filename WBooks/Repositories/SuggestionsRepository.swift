//
//  SuggestionsRepository.swift
//  WBooks
//
//  Created by Gaston Maspero on 13/06/2019.
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

enum SuggestionsError: Error {
    case decodeError
}

class SuggestionsRepository: AbstractRepository {
    
    private static let path = "/suggestions"
    
    func fetchSuggestions() -> SignalProducer<[Suggestion], RepositoryError> {
        let path = SuggestionsRepository.path
        
        return performRequest(method: .get, path: path) { json in
            return decode(json).toResult()
        }
    }
}
