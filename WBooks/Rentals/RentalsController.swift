//
//  RentalsController.swift
//  WBooks
//
//  Created by Gaston Maspero on 24/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import UIKit

class RentalsController: UIViewController {

    private var _booksController: BookTableController
    
    private var _suggestionsController: SuggestionsViewController
    
    private lazy var _view: RentalsView = RentalsView.loadFromNib()!
    
    init(booksController: BookTableController, suggestionsController: SuggestionsViewController) {
        _suggestionsController = suggestionsController
        _booksController = booksController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func loadView() {
        view = _view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNeedsStatusBarAppearanceUpdate()
        _view.setView(suggestionsView: _suggestionsController.view, rentedBooksView: _booksController.view)
        setAutoLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavBar(title: "NAVIGATION_BAR_TITLE_RENTALS".localized())
    }
    
    private func setAutoLayout() {
        guard let rentedBooks = _view.rentedBooksView else {
            return
        }
        
        guard let suggestions = _view.suggestionsView else {
            return
        }
        
        NSLayoutConstraint.activate([
            //Rentals
            rentedBooks.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 0),
            rentedBooks.leftAnchor.constraint(equalTo: _view.leftAnchor, constant: _view.margin),
            rentedBooks.rightAnchor.constraint(equalTo: _view.rightAnchor, constant: -_view.margin),
            rentedBooks.heightAnchor.constraint(equalToConstant: 500),
            //Label
            _view.suggestionsLabel.topAnchor.constraint(equalTo: rentedBooks.bottomAnchor, constant: 15),
            _view.suggestionsLabel.leftAnchor.constraint(equalTo: _view.leftAnchor, constant: _view.margin),
            _view.suggestionsLabel.rightAnchor.constraint(equalTo: _view.rightAnchor, constant: -_view.margin),
            //Suggestions
            suggestions.topAnchor.constraint(equalTo: _view.suggestionsLabel.bottomAnchor, constant: -5),
            suggestions.leftAnchor.constraint(equalTo: _view.leftAnchor, constant: 0),
            suggestions.rightAnchor.constraint(equalTo: _view.rightAnchor, constant: 0),
            suggestions.heightAnchor.constraint(equalToConstant: 100)
            ]
        )
    }
}
