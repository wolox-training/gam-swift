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
            self.comments.layer.cornerRadius = 30
            self.comments.clipsToBounds = true
            self.comments.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var loadingCommentsIndicator: UIActivityIndicatorView!

    func startActivityIndicator() {
        loadingCommentsIndicator.hidesWhenStopped = true
        loadingCommentsIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingCommentsIndicator.startAnimating()
    }
    
    func stopActivityIndicator() {
        loadingCommentsIndicator.stopAnimating()
    }
}
