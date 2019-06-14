//
//  SuggestionCell.swift
//  WBooks
//
//  Created by Gaston Maspero on 13/06/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import UIKit

class SuggestionCell: UICollectionViewCell {

    @IBOutlet weak var cover: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setCover(cover: UIImage) {
        self.cover.image = cover
    }
}
