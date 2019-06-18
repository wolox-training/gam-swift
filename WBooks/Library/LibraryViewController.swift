//
//  LibraryViewController.swift
//  WBooks
//
//  Created by Gaston Maspero on 13/06/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import UIKit
import WolmoCore

class LibraryViewController: UIViewController {
    
    private let margin: CGFloat = 20
    
    private var _booksController: BookTableController
    
    init(booksController: BookTableController) {
        _booksController = booksController
        super.init(nibName: nil, bundle: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNeedsStatusBarAppearanceUpdate()
        setupView()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureLibraryNavBar()
    }
    
    private func setupView() {
        view.addSubview(_booksController.view)
        view.backgroundColor = UIColor.wBooksBackground
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            _booksController.view.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 0),
            _booksController.view.leftAnchor.constraint(equalTo: view.leftAnchor, constant: margin),
            _booksController.view.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -margin),
            _booksController.view.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: 0)
            ]
        )
    }
    
    private func configureLibraryNavBar() {
        tabBarController?.setNavigationBarTitle("NAVIGATION_BAR_TITLE_LIBRARY".localized(), font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.medium), color: UIColor.white)
        //Left notification button
        tabBarController?.navigationItem.leftBarButtonItem = UIBarButtonItem.notificationButton()
        //Right search button
        tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem.searchButton()
    }
}
