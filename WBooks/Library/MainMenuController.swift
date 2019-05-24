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
    private lazy var _view: MainMenuView = MainMenuView.loadFromNib()!
    var books: [Book] = []
    
    init() {
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
        configureTableView()
    }
    
    override open var shouldAutorotate: Bool {
        return false
    }
    
    private func addBarButtons() {
        let nav = self.navigationController?.navigationBar
        self.title = "NAVIGATION_BAR_TITLE".localized()
        nav?.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        //Left notification button
        let notificationsButton = UIButton(type: .system)
        notificationsButton.setImage(#imageLiteral(resourceName: "ic_notifications").withRenderingMode(.alwaysOriginal), for: .normal)
        notificationsButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: notificationsButton)
        //Right search button
        let searchButton = UIButton(type: .system)
        searchButton.setImage(#imageLiteral(resourceName: "ic_search.png").withRenderingMode(.alwaysOriginal), for: .normal)
        searchButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchButton)
    }
    
    private func configureTableView() {
        books = createArray()
        _view.tableView.delegate = self
        _view.tableView.dataSource = self
        _view.tableView.register(cell: BookCell.self)
        _view.tableView.backgroundColor = UIColor.clear
        addBarButtons()
    }
    
    private func createArray() -> [Book] {
        var books: [Book] = []
        books.append(Book(title: "A little bird told me", author: "Timothy Cross", cover: #imageLiteral(resourceName: "img_book1")))
        books.append(Book(title: "When the doves disappeared", author: "Sofi Oksanen", cover: #imageLiteral(resourceName: "img_book2")))
        books.append(Book(title: "The best book in the world", author: "Peter Stjernstrom", cover: #imageLiteral(resourceName: "img_book3")))
        books.append(Book(title: "Be creative", author: "Unknown", cover: #imageLiteral(resourceName: "img_book4")))
        books.append(Book(title: "Redesign the web", author: "Many", cover: #imageLiteral(resourceName: "img_book5")))
        books.append(Book(title: "The yellow book", author: "Wolox Wolox", cover: #imageLiteral(resourceName: "img_book6")))

        return books
    }
}

extension MainMenuController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let book = books[indexPath.row]
        let cell = _view.tableView.dequeue(cell: BookCell.self)!
        cell.setBook(book: book)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.books.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
