//
//  BookTableAbstractViewModel.swift
//  WBooks
//
//  Created by Gaston Maspero on 13/06/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation
import ReactiveSwift

class BookTableAbstractViewModel {
    var books = [BookViewModel]()
    
    let state = MutableProperty(TableState.loading)
    
    func loadBooks() {
        func abstractFunction() {
            preconditionFailure("This method must be overridden")
        } 
    }
}
