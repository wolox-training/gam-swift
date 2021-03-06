//
//  BookCommentsViewController.swift
//  WBooks
//
//  Created by Gaston Maspero on 06/06/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import UIKit

class BookCommentsViewController: UIViewController {

    private lazy var _view: BookCommentsView = BookCommentsView.loadFromNib()!
    
    private var _viewModel: BookCommentsViewModel
    
    init(viewModel: BookCommentsViewModel) {
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
        configureCommentsTableView()
    }
    
    private func configureCommentsTableView() {
        _viewModel.state.producer.startWithValues { [weak self] state in
            if let this = self {
                switch state {
                case .loading:
                    this._view.startActivityIndicator()
                case .error, .empty:
                    this._view.stopActivityIndicator()
                    this._view.displayCommentsIndicator(state: this._viewModel.state.value)
                case .withValues:
                    this._view.stopActivityIndicator()
                    this._view.comments.reloadData()
                }
            }
        }
        _viewModel.loadComments(bookID: _viewModel.bookViewModel.id)
        _view.comments.delegate = self
        _view.comments.dataSource = self
        _view.comments.register(cell: BookCommentCell.self)
    }
}

extension BookCommentsViewController: UITableViewDataSource, UITableViewDelegate {
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
