//
//  DetailViewModel.swift
//  WBooks
//
//  Created by Gaston Maspero on 30/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation

class DetailViewModel {
    
    var bookViewModel: BookViewModel
    
    var userId: Int
    
    init(bookViewModel: BookViewModel, id: Int) {
        self.bookViewModel = bookViewModel
        self.userId = id
    }
}
