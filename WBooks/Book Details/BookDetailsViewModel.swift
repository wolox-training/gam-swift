//
//  BookDetailsViewModel.swift
//  WBooks
//
//  Created by Gaston Maspero on 06/06/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation
import UIKit
import ReactiveSwift

enum Availability: String {
    case available
    case notAvailable
    case inHands
    case notLoaded
    
    var textColor: UIColor {
        switch self {
        case .available:
            return UIColor.green
        case .notAvailable:
            return UIColor.red
        case .inHands:
            return UIColor.blue
        case .notLoaded:
            return UIColor.gray
        }
    }
    
    var text: String {
        switch self {
        case .available:
            return "AVAILABLE".localized()
        case .notAvailable:
            return "UNAVAILABLE".localized()
        case .inHands:
            return "IN_HANDS".localized()
        case .notLoaded:
            return ""
        }
    }
}

enum RentState {
    case sleep
    case rentSuccess
    case rentError
}

class BookDetailsViewModel {
    
    var bookViewModel: BookViewModel
    
    let rentsRepository = RepositoryBuilder.getDefaultRentsRepository()
    
    var rents: [Rent] = []
    
    let status = MutableProperty(Availability.notLoaded)
    
    let rentState = MutableProperty(RentState.sleep)
    
    init(bookViewModel: BookViewModel) {
        self.bookViewModel = bookViewModel
    }
    
    func loadRents() {
        rentsRepository.fetchRents().startWithResult { [weak self] result in
            guard let this = self else {
                return
            }
            switch result {
            case .success(let resultArray):
                this.rents = resultArray
                if this.bookViewModel.status == "Available" || this.bookViewModel.status == "available" {
                    this.status.value = .available
                } else if this.isBookOnHands() {
                    this.status.value = .inHands
                } else {
                    this.status.value = .notAvailable
                }
            case .failure(let error):
                // Here you can use error if you need it
                print(error)
            }
        }
    }
    
    func rentBook() {
        let today = Date().toString()
        let tomorrow = Date().adding(days: 1).toString()
        rentsRepository.rentBook(bookID: bookViewModel.id, from: today, to: tomorrow).startWithResult { [weak self] result in
            guard let this = self else {
                return
            }
            switch result {
            case .success:
                this.bookViewModel.status = "rented"
                this.status.value = .inHands
                this.rentState.value = .rentSuccess
            case .failure(let error):
                // Here you can use error if you need it
                this.rentState.value = .rentError
                print(error)
            }
        }
    }
    
    private func isBookOnHands() -> Bool {
        for rent in rents where bookViewModel.id == rent.book.id {
            return true
        }
        return false
    }
}
