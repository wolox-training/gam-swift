//
//  Buttons.swift
//  WBooks
//
//  Created by Gaston Maspero on 10/06/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation
import WolmoCore

extension UIButton {
    func setWBookGradient() {
        gradient = UIButton.wBooksButtonGradient
    }
    
    static var wBooksButtonGradient: ViewGradient {
        let gradient = ViewGradient(colors: [UIColor.wBooksLeftGradientColor, UIColor.wBooksRightGradientColor], direction: .leftToRight)
        return gradient
    }
}
