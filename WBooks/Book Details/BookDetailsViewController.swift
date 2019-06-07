//
//  BookDetailsViewController.swift
//  WBooks
//
//  Created by Gaston Maspero on 06/06/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import UIKit
import WolmoCore

class BookDetailsViewController: UIViewController {

    private lazy var _view: BookDetailsView = BookDetailsView.loadFromNib()!
    
    private var _viewModel: BookDetailsViewModel
    
    init(viewModel: BookDetailsViewModel) {
        _viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = _view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBookDetails()
    }
    
    private func setBookDetails() {
        _view.setBook(bookViewModel: _viewModel.bookViewModel)
        _viewModel.loadRents(onSuccess: onLoadRentsSuccess)
    }
    
    func onLoadRentsSuccess(rents: [Rent]) {
        _viewModel.onLoadRentsSuccess(rents: rents)
        _view.setAvailability(status: _viewModel.status)
        _view.rent.addTarget(self, action: #selector(rent), for: .touchUpInside)
    }
    
    @objc func rent() {
        switch _viewModel.status {
        case .available:
            let alert = UIAlertController(alertViewModel: ErrorAlertViewModel(title: "THANKS".localized(), message: "PROCESSING_RENT".localized(), dismissButtonTitle: "ACCEPT".localized()))
            self.present(alert, animated: true, completion: nil)
            _viewModel.rentBook(onSuccess: onBookRentSuccess, onError: onBookRentError)
        case .notAvailable, .inHands:
            let alert = UIAlertController(alertViewModel: ErrorAlertViewModel(title: "UPS".localized(), message: "CANNOT_RENT".localized(), dismissButtonTitle: "ACCEPT".localized()))
            self.present(alert, animated: true, completion: nil)
        case .notLoaded:
            let alert = UIAlertController(alertViewModel: ErrorAlertViewModel(title: "UPS".localized(), message: "RENT_ERROR".localized(), dismissButtonTitle: "ACCEPT".localized()))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func onBookRentSuccess() {
        _viewModel.onBookRentSuccess()
        let alert = UIAlertController(alertViewModel: ErrorAlertViewModel(title: "THANKS".localized(), message: "RENT_COMPLETED".localized(), dismissButtonTitle: "ACCEPT".localized()))
        self.present(alert, animated: true, completion: nil)
        _view.setAvailability(status: _viewModel.status)
    }
    
    func onBookRentError() {
        let alert = UIAlertController(alertViewModel: ErrorAlertViewModel(title: "ERROR".localized(), message: "RENT_ERROR".localized(), dismissButtonTitle: "ACCEPT".localized()))
        self.present(alert, animated: true, completion: nil)
    }
}
