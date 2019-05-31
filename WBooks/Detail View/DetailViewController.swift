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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = _view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        _view.setBook(bookViewModel: _viewModel.bookViewModel)
    }
}
