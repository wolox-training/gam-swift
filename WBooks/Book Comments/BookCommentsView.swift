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

    @IBOutlet weak var comments: UITableView! {
        didSet {
            self.comments.layer.cornerRadius = 10
            self.comments.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var loadingCommentsIndicator: UIActivityIndicatorView!

    override func awakeFromNib() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func startActivityIndicator() {
        loadingCommentsIndicator.hidesWhenStopped = true
        loadingCommentsIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingCommentsIndicator.startAnimating()
    }
    
    func stopActivityIndicator() {
        loadingCommentsIndicator.stopAnimating()
    }
}
