//
//  MainMenu.swift
//  WBooks
//
//  Created by Gaston Maspero on 22/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import UIKit
import WolmoCore

class BookTableController: UIViewController {
    
    private weak var _superViewController: UIViewController?
    
    private let _viewModel: BookTableAbstractViewModel
    
    private lazy var _view: BookTableView = BookTableView.loadFromNib()!
    
    init(viewModel: BookTableAbstractViewModel) {
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
        setNeedsStatusBarAppearanceUpdate()
        configureTableView()
    }
    
    func setSuperViewController(superViewController: UIViewController) {
        _superViewController = superViewController
    }
    
    private func configureTableView() {
        _viewModel.state.producer.startWithValues { [weak self] state in
            if let this = self {
                switch state {
                case .loading:
                    this._view.startActivityIndicator()
                case .error, .empty:
                    this._view.stopActivityIndicator()
                    this._view.displayNoBooks(state: this._viewModel.state.value)
                case .withValues:
                    this._view.stopActivityIndicator()
                    this._view.tableView.reloadData()
                }
            }
        }
        _viewModel.loadBooks()
        _view.tableView.delegate = self
        _view.tableView.dataSource = self
        _view.tableView.register(cell: BookCell.self)
        _view.tableView.backgroundColor = UIColor.clear
    }
}

extension BookTableController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let bookViewModel = _viewModel.books[indexPath.row]
        let cell = _view.tableView.dequeue(cell: BookCell.self)!
        cell.setBook(bookViewModel: bookViewModel)
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Cell selected")
        guard let superViewController = _superViewController else {
            return
        }
        let bookViewModel = _viewModel.books[indexPath.row]
        let bookInfoViewModel = BookInfoViewModel(bookViewModel: bookViewModel)
        let commentsController = BookCommentsViewController(viewModel: BookCommentsViewModel(bookViewModel: bookViewModel))
        let bookDetailsController = BookDetailsViewController(viewModel: BookDetailsViewModel(bookViewModel: bookViewModel))
        
        let controller = BookInfoViewController(viewModel: bookInfoViewModel, commentsController: commentsController, bookDetailsController: bookDetailsController)
        superViewController.navigationController?.pushViewController(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _viewModel.books.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
