//
//  SuggestionCell.swift
//  WBooks
//
//  Created by Gaston Maspero on 13/06/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import UIKit
import WolmoCore

class SuggestionCell: UICollectionViewCell, NibLoadable {
    @IBOutlet weak var cover: UIImageView!
    
    func setCover(book: BookViewModel) {
        self.cover.image = book.cover
    }
}
