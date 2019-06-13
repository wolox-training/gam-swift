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

    private let processingRentAlert = UIAlertController(title: "THANKS".localized(), message: "PROCESSING_RENT".localized(),
                                                preferredStyle: .alert)
    
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
        setRentButton()
    }
    
    private func setBookDetails() {
        _view.setBook(bookViewModel: _viewModel.bookViewModel)
        _viewModel.status.producer.startWithValues { [weak self] status in
            guard let this = self else {
                return
            }
            this._view.setAvailability(status: status)
        }
        _viewModel.loadRents()
    }
    
    func setRentButton() {
        //Rent button action
        _view.rent.reactive.controlEvents(.touchUpInside).observeValues { [weak self] _ in
            self?.rent()
        }
        
        //Actions when rent request is completed
        _viewModel.rentState.producer.startWithValues { [weak self] state in
            guard let this = self else {
                return
            }
            switch state {
            case .error:
                this.processingRentAlert.dismiss(animated: true, completion: nil)
                let alert = UIAlertController(alertViewModel: ErrorAlertViewModel(title: "ERROR".localized(), message: "RENT_ERROR".localized(), dismissButtonTitle: "ACCEPT".localized()))
                this.present(alert, animated: true, completion: nil)
            case .success:
                this.processingRentAlert.dismiss(animated: true, completion: nil)
                let alert = UIAlertController(alertViewModel: ErrorAlertViewModel(title: "THANKS".localized(), message: "RENT_COMPLETED".localized(), dismissButtonTitle: "ACCEPT".localized()))
                this.present(alert, animated: true, completion: nil)
                this._view.setAvailability(status: this._viewModel.status.value)
            case .sleep:
                break
            }
        }
    }

    func rent() {
        switch _viewModel.status.value {
        case .available:
            present(processingRentAlert, animated: true, completion: nil)
            _viewModel.rentBook()
        case .notAvailable:
            let alert = UIAlertController(alertViewModel: ErrorAlertViewModel(title: "UPS".localized(), message: "CANNOT_RENT".localized(), dismissButtonTitle: "ACCEPT".localized()))
            present(alert, animated: true, completion: nil)
        case .inHands:
            let alert = UIAlertController(alertViewModel: ErrorAlertViewModel(title: "UPS".localized(), message: "ALREADY_IN_HANDS".localized(), dismissButtonTitle: "ACCEPT".localized()))
            present(alert, animated: true, completion: nil)
        case .notLoaded:
            let alert = UIAlertController(alertViewModel: ErrorAlertViewModel(title: "UPS".localized(), message: "RENT_ERROR".localized(), dismissButtonTitle: "ACCEPT".localized()))
            present(alert, animated: true, completion: nil)
        }
    }
}
