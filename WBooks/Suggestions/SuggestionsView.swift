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
    
    override func awakeFromNib() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
    }
}
