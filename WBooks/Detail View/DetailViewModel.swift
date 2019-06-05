//
//  DetailViewModel.swift
//  WBooks
//
//  Created by Gaston Maspero on 30/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation
import WolmoCore

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

class DetailViewModel {
    
    var bookViewModel: BookViewModel
    
    var rents: [Rent] = []
    
    var status: Availability = .notLoaded
    
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
    
    func rentBook(onSuccess: @escaping () -> Void, onError: @escaping () -> Void) {
        let today = Date().toString()
        let tomorrow = Date().adding(days: 1).toString()
        RentsRepository.rentBook(onSuccess: onSuccess, onError: onError, bookID: bookViewModel.id, from: today, to: tomorrow)
    }
    
    func onBookRentSuccess() {
        bookViewModel.status = "rented"
        self.status = .inHands
    }
    
    private func isBookOnHands() -> Bool {
        for rent in rents where bookViewModel.id == rent.book.id {
            return true
        }
        return false
    }
}
