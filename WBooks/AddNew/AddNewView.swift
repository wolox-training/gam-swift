//
//  AddNewView.swift
//  WBooks
//
//  Created by Gaston Maspero on 07/06/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import UIKit
import WolmoCore

class AddNewView: UIView, NibLoadable {
    
    @IBOutlet weak var formFrame: UIView! {
        didSet {
            self.formFrame.layer.cornerRadius = 10
            self.formFrame.clipsToBounds = true
        }
    }
    @IBOutlet weak var submitButton: UIButton! {
        didSet {
            self.submitButton.layer.cornerRadius = 20
            self.submitButton.clipsToBounds = true
            self.submitButton.gradient = UIColor.wBooksButtonGradient()
        }
    }
    
    func setView() {
        self.backgroundColor = UIColor.wBooksBackground
    }
}
