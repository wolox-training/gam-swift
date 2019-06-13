//
//  BookCommentsViewModel.swift
//  WBooks
//
//  Created by Gaston Maspero on 06/06/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation
import ReactiveSwift

class BookCommentsViewModel {
    
    var bookViewModel: BookViewModel
    
    var comments = [Comment]()
    
    let commentsRepository = RepositoryBuilder.getDefaultCommentsRepository()
    
    let state = MutableProperty(TableState.loading)
    
    init(bookViewModel: BookViewModel) {
        self.bookViewModel = bookViewModel
    }
    
    func loadComments(bookID: Int) {
        commentsRepository.fetchComments(bookID: bookID).startWithResult { [weak self] result in
            switch result {
            case .success(let resultArray):
                self?.comments = resultArray
                self?.state.value = resultArray.isEmpty ? .empty : .withValues
            case .failure(let error):
                // Here you can use error if you need it
                self?.state.value = .error
                print(error)
            }
        }
    }
}
