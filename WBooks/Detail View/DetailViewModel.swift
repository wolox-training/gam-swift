//
//  DetailViewModel.swift
//  WBooks
//
//  Created by Gaston Maspero on 30/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation

enum Availability {
    case available
    case notAvailable
    case inHands
}

class DetailViewModel {
    
    var bookViewModel: BookViewModel
    
    var rents: [Rent] = []
    
    var status: Availability?
    
    init(bookViewModel: BookViewModel) {
        self.bookViewModel = bookViewModel
    }
    
    func loadRents(onSuccess: @escaping ([Rent]) -> Void) {
        RentsRepository.fetchRents(onSuccess: onSuccess, onError: onError)
    }
    
    func onLoadRentsSuccess(rents: [Rent]) {
        self.rents = rents
        if bookViewModel.status == "Available" || bookViewModel.status == "available" {
            self.status = .available
        } else if isBookOnHands() {
            self.status = .inHands
        } else {
            self.status = .notAvailable
        }
    }
    
    func onError(error: Error) {
        return
    }
    
    func rentBook(onSuccess: @escaping () -> Void) {
        let today = Date().toString()
        let tomorrow = Date().adding(days: 1).toString()
        RentsRepository.rentBook(onSuccess: onSuccess, bookID: bookViewModel.id, from: today, to: tomorrow)
    }
    
    func onBookRentSuccess() {
        bookViewModel.status = "rented"
    }
    
    private func isBookOnHands() -> Bool {
        for rent in rents where bookViewModel.id == rent.book.id {
            return true
        }
        return false
    }
}
