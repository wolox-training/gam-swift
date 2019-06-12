//
//  TextFieldExtension.swift
//  WBooks
//
//  Created by Gaston Maspero on 10/06/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    func setBottomBorder(borderColor: UIColor, width: Double) {
        borderStyle = UITextBorderStyle.none
        backgroundColor = UIColor.clear
        let borderLine = UIView()
        borderLine.frame = CGRect(x: 0, y: Double(frame.height) - width, width: Double(frame.width), height: width)
        borderLine.backgroundColor = borderColor
        addSubview(borderLine)
    }
}
