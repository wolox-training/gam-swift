//
//  MainMenuView.swift
//  WBooks
//
//  Created by Gaston Maspero on 22/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation
import UIKit
import WolmoCore

class BookTableView: UIView, NibLoadable {
    @IBOutlet weak var tableView: UITableView!
    
    override func awakeFromNib() {
        translatesAutoresizingMaskIntoConstraints = false
    }
}
