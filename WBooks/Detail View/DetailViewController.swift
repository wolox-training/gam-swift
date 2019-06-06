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
        configureCommentsTableView()
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
    
    private func configureCommentsTableView() {
        _view.startActivityIndicator()
        _viewModel.loadComments(onSuccess: onCommentLoadSuccess, bookID: _viewModel.bookViewModel.id)
        _view.comments.delegate = self
        _view.comments.dataSource = self
        _view.comments.register(cell: BookCommentCell.self)
        _view.comments.backgroundColor = UIColor.clear
    }
    
    func onCommentLoadSuccess(comments: [Comment]) {
        _viewModel.onCommentLoadSuccess(comments: comments)
        _view.stopActivityIndicator()
        _view.comments.reloadData()
    }
}

extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let comment = _viewModel.comments[indexPath.row]
        let cell = _view.comments.dequeue(cell: BookCommentCell.self)!
        cell.setComment(comment: comment)
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _viewModel.comments.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
