//
//  RentalsViewModel.swift
//  WBooks
//
//  Created by Gaston Maspero on 07/06/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation
import ReactiveSwift

class RentalsViewModel: BookTableAbstractViewModel {
    
    var books = [BookViewModel]()
    
    var state = MutableProperty(TableState.loading)
    
    let rentRepository = RepositoryBuilder.getDefaultRentsRepository()
    
    func loadBooks() {
        rentRepository.fetchRents().startWithResult { [weak self] result in
            guard let this = self else {
                return
            }
            switch result {
            case .success(let resultArray):
                this.books = resultArray.map { (rent) in
                    BookViewModel(book: rent.book)
                }
                this.state.value = resultArray.isEmpty ? .empty : .withValues
            case .failure(let error):
                this.state.value = .error
                print(error)
            }
        }
    }
}
