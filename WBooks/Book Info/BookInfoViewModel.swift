//
//  DetailViewModel.swift
//  WBooks
//
//  Created by Gaston Maspero on 30/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation
import WolmoCore

class BookInfoViewModel {
    
    var bookViewModel: BookViewModel

    init(bookViewModel: BookViewModel) {
        self.bookViewModel = bookViewModel
    }
}
