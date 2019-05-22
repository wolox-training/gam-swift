//
//  MainMenu.swift
//  WBooks
//
//  Created by Gaston Maspero on 22/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import UIKit
import WolmoCore

class MainMenuController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
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
        books = createArray()
        _view.tableView.delegate = self
        _view.tableView.dataSource = self
        _view.tableView.register(cell: CustomCell.self)
        _view.tableView.rowHeight = UITableViewAutomaticDimension
        _view.tableView.estimatedRowHeight = 240
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let book = books[indexPath.row]
        let cell = _view.tableView.dequeue(cell: CustomCell.self)!
        cell.setBook(book: book)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func createArray() ->[Book]{
        var books: [Book] = []
        books.append(Book(title: "A little bird told me", author: "Timothy Cross", cover: #imageLiteral(resourceName: "img_book1")))
        books.append(Book(title: "When the doves disappeared", author: "Sofi Oksanen", cover: #imageLiteral(resourceName: "img_book2")))
        books.append(Book(title: "The best book in the world", author: "Peter Stjernstrom", cover: #imageLiteral(resourceName: "img_book3")))

        return books
    }
}
