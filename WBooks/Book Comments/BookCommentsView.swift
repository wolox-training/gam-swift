//
//  BookCommentsView.swift
//  WBooks
//
//  Created by Gaston Maspero on 06/06/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import UIKit
import WolmoCore

class BookCommentsView: UIView, NibLoadable {

    let commentIndicator = UILabel()
    
    @IBOutlet weak var comments: UITableView! {
        didSet {
            comments.layer.cornerRadius = 10
            comments.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var loadingCommentsIndicator: UIActivityIndicatorView!

    override func awakeFromNib() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func startActivityIndicator() {
        loadingCommentsIndicator.hidesWhenStopped = true
        loadingCommentsIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingCommentsIndicator.startAnimating()
    }
    
    func stopActivityIndicator() {
        loadingCommentsIndicator.stopAnimating()
    }
    
    func displayCommentsIndicator(state: TableState) {
        if state == TableState.empty {
            commentIndicator.text = "NO_COMMENTS".localized()
        }
        if state == TableState.error {
            commentIndicator.text = "COMMENT_ERROR".localized()
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
