//
//  MainMenu.swift
//  WBooks
//
//  Created by Gaston Maspero on 22/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import UIKit
import WolmoCore

class MainMenuController: UIViewController {
    
    private let _viewModel: MainMenuViewModel
    
    private lazy var _view: MainMenuView = MainMenuView.loadFromNib()!
    
    init(viewModel: MainMenuViewModel) {
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
    
    override open var shouldAutorotate: Bool {
        return false
    }
    
    func onSuccess(books: [Book]) {
        _viewModel.onSuccess(books: books)
        _view.tableView.reloadData()
    }
    
    private func configureTableView() {
        _viewModel.loadBooks(onSuccess: onSuccess)
        _view.tableView.delegate = self
        _view.tableView.dataSource = self
        _view.tableView.register(cell: BookCell.self)
        _view.tableView.backgroundColor = UIColor.clear
    }
}

extension MainMenuController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let bookViewModel = _viewModel.books[indexPath.row]
        let cell = _view.tableView.dequeue(cell: BookCell.self)!
        cell.setBook(bookViewModel: bookViewModel)
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = UINavigationController(rootViewController: DetailViewController())
        present(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _viewModel.books.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
