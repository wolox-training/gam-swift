//
//  RentalsController.swift
//  WBooks
//
//  Created by Gaston Maspero on 24/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import UIKit

class RentalsController: UIViewController {

    private let margin: CGFloat = 20
    
    private var _booksController: BookTableController
    
    private var _suggestionsController: SuggestionsViewController
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNeedsStatusBarAppearanceUpdate()
        setupView()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavBar(title: "NAVIGATION_BAR_TITLE_RENTALS".localized())
    }
    
    private func setupView() {
//        view.addSubview(_booksController.view)
        view.addSubview(_suggestionsController.view)
        view.backgroundColor = UIColor.wBooksBackground
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            //Rentals
//            _booksController.view.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 0),
//            _booksController.view.leftAnchor.constraint(equalTo: view.leftAnchor, constant: margin),
//            _booksController.view.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -margin),
//            _booksController.view.heightAnchor.constraint(equalToConstant: 500),
//            _booksController.view.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: 0)
            //Suggestions
            _suggestionsController.view.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 0),
            _suggestionsController.view.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            _suggestionsController.view.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            _suggestionsController.view.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: 5)
            ]
        )
    }
    
}
