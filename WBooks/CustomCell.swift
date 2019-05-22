//
//  CustomCell.swift
//  WBooks
//
//  Created by Gaston Maspero on 22/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var cellLabel: UILabel!
    
    func setText(text: String){
        cellLabel.text = text
    }

}
