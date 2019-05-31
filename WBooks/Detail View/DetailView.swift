//
//  DetailView.swift
//  WBooks
//
//  Created by Gaston Maspero on 30/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import UIKit
import WolmoCore

class DetailView: UIView, NibLoadable {
    
    @IBOutlet weak var detailCell: UIView! {
        didSet {
            self.detailCell.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var availability: UILabel!
    
    @IBOutlet weak var author: UILabel!
    
    @IBOutlet weak var year: UILabel!
    
    @IBOutlet weak var genre: UILabel!
    
    @IBOutlet weak var cover: UIImageView!
    
    @IBOutlet weak var addToWishlist: UIButton! {
        didSet {
            self.addToWishlist.layer.cornerRadius = 20
            self.addToWishlist.layer.borderWidth = 1
            self.addToWishlist.backgroundColor = .clear
            self.addToWishlist.clipsToBounds = true
            self.addToWishlist.layer.borderColor = UIColor(red: 73/255, green: 194/255, blue: 1, alpha: 1).cgColor
        }
    }
    
    @IBOutlet weak var rent: UIButton! {
        didSet {
            self.rent.layer.cornerRadius = 20
            self.rent.clipsToBounds = true
        }
    }
    
    func setBook(bookViewModel: BookViewModel) {
        title.text = bookViewModel.title
        availability.text = "TODO"
        author.text = bookViewModel.author
        year.text = bookViewModel.year
        genre.text = bookViewModel.genre
        cover.image = bookViewModel.cover
    }
    
}
