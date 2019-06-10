//
//  formField.swift
//  WBooks
//
//  Created by Gaston Maspero on 10/06/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class FormField: UITextField {
    
    @IBInspectable
    public var fontSize: CGFloat = 15.0 {
        didSet {
            attributedPlaceholder = NSAttributedString(string: formPlaceholder, attributes: [NSAttributedStringKey.font: UIFont.italicSystemFont(ofSize: fontSize)])
        }
    }
    
    @IBInspectable
    public var formPlaceholder: String = "Text goes here..." {
        didSet {
            attributedPlaceholder = NSAttributedString(string: formPlaceholder, attributes: [NSAttributedStringKey.font: UIFont.italicSystemFont(ofSize: fontSize)])
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        borderStyle = UITextBorderStyle.none
        backgroundColor = UIColor.clear
        attributedPlaceholder = NSAttributedString(string: formPlaceholder, attributes: [NSAttributedStringKey.foregroundColor: UIColor.wBooksPlaceholderGray, NSAttributedStringKey.font: UIFont.italicSystemFont(ofSize: fontSize)])
        setBottomBorder(borderColor: UIColor.wBooksPlaceholderGray, width: 1)
    }
}
