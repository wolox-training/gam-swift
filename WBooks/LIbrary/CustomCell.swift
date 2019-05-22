//
//  CustomCell.swift
//  WBooks
//
//  Created by Gaston Maspero on 22/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import UIKit
import WolmoCore

class CustomCell: UITableViewCell, NibLoadable {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var cover: UIImageView!
    
    func setBook(book: Book){
        title.text = book.title
        author.text = book.author
        cover.image = book.cover
    }
}
