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
    
    let comments = MutableProperty<[Comment]>([])
    
    init(bookViewModel: BookViewModel) {
        self.bookViewModel = bookViewModel
    }
    
    func loadComments(onSuccess: @escaping ([Comment]) -> Void, bookID: Int) {
        CommentsRepository.fetchComments(onSuccess: onSuccess, onError: onError, bookID: bookID)
    }
    
    func onCommentLoadSuccess(comments: [Comment]) {
        self.comments.value = comments
    }
    
    func onError(error: Error) {
        return
    }
}
