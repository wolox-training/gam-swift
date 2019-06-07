//
//  DetailViewController.swift
//  WBooks
//
//  Created by Gaston Maspero on 30/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import UIKit
import WolmoCore

class BookInfoViewController: UIViewController {
    
    private let margin: CGFloat = 20
    
    private lazy var _view: BookInfoView = BookInfoView.loadFromNib()!
    
    private var _viewModel: BookInfoViewModel
    
    private var _commentsController: BookCommentsViewController
    
    private var _bookDetailsController: BookDetailsViewController
    
    init(viewModel: BookInfoViewModel, commentsController: BookCommentsViewController, bookDetailsController: BookDetailsViewController) {
        _viewModel = viewModel
        _commentsController = commentsController
        _bookDetailsController = bookDetailsController
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
        addNavBarButtons()
        view.addSubview(_bookDetailsController.view)
        view.addSubview(_commentsController.view)
        setupLayout()
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            //Book details
            _bookDetailsController.view.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 10),
            _bookDetailsController.view.leftAnchor.constraint(equalTo: view.leftAnchor, constant: margin),
            _bookDetailsController.view.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -margin),
            //Comments
            _commentsController.view.topAnchor.constraint(equalTo: _bookDetailsController.view.bottomAnchor, constant: 10),
            _commentsController.view.leftAnchor.constraint(equalTo: view.leftAnchor, constant: margin),
            _commentsController.view.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -margin),
            _commentsController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
            ]
        )
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
