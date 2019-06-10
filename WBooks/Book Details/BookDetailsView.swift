//
//  BookDetailsView.swift
//  WBooks
//
//  Created by Gaston Maspero on 06/06/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import UIKit
import WolmoCore

class BookDetailsView: UIView, NibLoadable {
    @IBOutlet weak var detailCell: UIView! {
        didSet {
            detailCell.layer.cornerRadius = 10
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
            addToWishlist.layer.cornerRadius = 20
            addToWishlist.layer.borderWidth = 1
            addToWishlist.backgroundColor = .clear
            addToWishlist.clipsToBounds = true
            addToWishlist.layer.borderColor = UIColor.wBooksBlue
        }
    }
    
    @IBOutlet weak var rent: UIButton! {
        didSet {
            rent.layer.cornerRadius = 20
            rent.clipsToBounds = true
            rent.setWBookGradient()
        }
    }
    
    override func awakeFromNib() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setBook(bookViewModel: BookViewModel) {
        title.text = bookViewModel.title
        author.text = bookViewModel.author
        year.text = bookViewModel.year
        genre.text = bookViewModel.genre
        cover.image = bookViewModel.cover
    }
    
    func setAvailability(status: Availability) {
        availability.text = status.text
        availability.textColor = status.textColor
    }
}
