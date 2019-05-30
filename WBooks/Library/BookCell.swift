//
//  CustomCell.swift
//  WBooks
//
//  Created by Gaston Maspero on 22/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import UIKit
import WolmoCore

class BookCell: UITableViewCell, NibLoadable {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var cover: UIImageView!
    @IBOutlet weak var viewBackground: UIView! {
        didSet {
            self.viewBackground.layer.cornerRadius = 10
            self.viewBackground.clipsToBounds = true
        }
    }
    
    override func awakeFromNib() {
        backgroundColor = UIColor.clear
    }
    
    func setBook(bookViewModel: BookViewModel) {
        title.text = bookViewModel.title
        author.text = bookViewModel.author
        let url = URL(string: bookViewModel.image)
        if let url = url {
            do {
                let data = try Data(contentsOf: url)
                cover.image = UIImage(data: data)
            } catch {
                cover.image = UIImage(named: "no_image_available")
            }
        }
    }
}
