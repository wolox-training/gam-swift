//
//  BookCommentCellTableViewCell.swift
//  WBooks
//
//  Created by Gaston Maspero on 04/06/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import UIKit
import WolmoCore

class BookCommentCell: UITableViewCell, NibLoadable {

    @IBOutlet weak var profilePic: UIImageView! {
        didSet {
            self.profilePic.layer.borderWidth = 1.5
            self.profilePic.layer.masksToBounds = false
            self.profilePic.layer.borderColor = UIColor.wBooksBlue
            self.profilePic.layer.cornerRadius = self.profilePic.layer.frame.height / 2
            self.profilePic.clipsToBounds = true
        }
    }
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var content: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setComment(comment: Comment) {
        userName.text = comment.user.username
        content.text = comment.content
        profilePic.image = comment.profilePic
    }
}
