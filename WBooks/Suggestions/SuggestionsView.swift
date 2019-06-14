//
//  SuggestionsView.swift
//  WBooks
//
//  Created by Gaston Maspero on 13/06/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import UIKit
import WolmoCore

class SuggestionsView: UIView, NibLoadable {
    @IBOutlet weak var suggestionCollectionView: UICollectionView! {
        didSet {
            suggestionCollectionView.backgroundColor = UIColor.clear
        }
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let commentIndicator = UILabel()
    
    override func awakeFromNib() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
    }
    
    func startActivityIndicator() {
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        activityIndicator.startAnimating()
    }
    
    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
    }
    
    func displayNoSuggestionsIndicator(state: TableState) {
        if state == TableState.empty {
            commentIndicator.text = "NO_SUGGESTIONS".localized()
        }
        if state == TableState.error {
            commentIndicator.text = "SUGGESTIONS_ERROR".localized()
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
