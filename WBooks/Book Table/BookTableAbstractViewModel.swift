//
//  BookTableAbstractViewModel.swift
//  WBooks
//
//  Created by Gaston Maspero on 13/06/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation
import ReactiveSwift

protocol BookTableAbstractViewModel {
    var books: [BookViewModel] { get set }
    
    var state: MutableProperty<TableState> { get set }
    
    func loadBooks()
}
