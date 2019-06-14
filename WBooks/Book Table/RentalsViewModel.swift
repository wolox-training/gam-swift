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
    
    private var rents = [Rent]()
    
    let rentRepository = RepositoryBuilder.getDefaultRentsRepository()
    
    override func loadBooks() {
        rentRepository.fetchRents().startWithResult { [weak self] result in
            guard let this = self else {
                return
            }
            switch result {
            case .success(let resultArray):
                this.rents = resultArray
                this.books = this.rents.map { (rent) in
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
