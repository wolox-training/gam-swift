//
//  StartingScreenView.swift
//  WBooks
//
//  Created by Gaston Maspero on 22/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import UIKit
import WolmoCore

class StartingScreenZeroView: UIView, NibLoadable {
    @IBOutlet weak var signInGoogleButton: UIButton! {
        didSet {
            self.signInGoogleButton.layer.cornerRadius = 25
            self.signInGoogleButton.layer.borderWidth = 2
            self.signInGoogleButton.backgroundColor = .clear
            self.signInGoogleButton.clipsToBounds = true
            self.signInGoogleButton.layer.borderColor = UIColor.white.cgColor
        }
    }
}
