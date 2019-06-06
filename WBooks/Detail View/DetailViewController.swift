//
//  DetailViewController.swift
//  WBooks
//
//  Created by Gaston Maspero on 30/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import UIKit
import WolmoCore

class DetailViewController: UIViewController {
    
    private lazy var _view: DetailView = DetailView.loadFromNib()!
    
    private var _viewModel: DetailViewModel
    
    init(viewModel: DetailViewModel) {
        _viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = _view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setNeedsStatusBarAppearanceUpdate()
        setBookDetails()
        addNavBarButtons()
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
            let alert = UIAlertController(alertViewModel: ErrorAlertViewModel(title: "UPS!", message: "CANNOT_RENT".localized(), dismissButtonTitle: "ACCEPT".localized()))
            self.present(alert, animated: true, completion: nil)
        case .notLoaded:
            let alert = UIAlertController(alertViewModel: ErrorAlertViewModel(title: "UPS!", message: "RENT_ERROR".localized(), dismissButtonTitle: "ACCEPT".localized()))
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
        let alert = UIAlertController(alertViewModel: ErrorAlertViewModel(title: "Error!", message: "RENT_ERROR".localized(), dismissButtonTitle: "ACCEPT".localized()))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func addNavBarButtons() {
        setNavigationBarTitle("BOOK_DETAIL".localized(), font: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.medium), color: UIColor.white)
        //Back button
        let backButton = UIButton(type: .system)
        backButton.setImage(#imageLiteral(resourceName: "ic_back").withRenderingMode(.alwaysOriginal), for: .normal)
        backButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        backButton.addTarget(self, action: #selector(backAction), for: UIControlEvents.touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    @objc private func backAction() {
        if let currentNavigationController = navigationController {
            currentNavigationController.popViewController(animated: true)
        }
    }
}
