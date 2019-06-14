//
//  MainMenuView.swift
//  WBooks
//
//  Created by Gaston Maspero on 22/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation
import UIKit
import WolmoCore

class BookTableView: UIView, NibLoadable {
    
    let commentIndicator = UILabel()
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.layer.cornerRadius = 10
            self.tableView.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func startActivityIndicator() {
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        activityIndicator.startAnimating()
    }
    
    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
    }
    
    func displayNoBooks(state: TableState) {
        if state == TableState.empty {
            commentIndicator.text = "NO_BOOKS".localized()
        }
        if state == TableState.error {
            commentIndicator.text = "BOOK_ERROR".localized()
        }
        commentIndicator.textColor = UIColor.gray
        addSubview(commentIndicator)
        commentIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            commentIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            commentIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ]
        )
    }
}
