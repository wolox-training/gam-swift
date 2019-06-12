//
//  ImagePicker.swift
//  WBooks
//
//  Created by Gaston Maspero on 11/06/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation
import UIKit

extension UIImagePickerController {
    
    convenience init(color: UIColor) {
        self.init()
        isNavigationBarHidden = false
        navigationBar.isTranslucent = false
        navigationBar.tintColor = color
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: color]
    }
    
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    static var imagePicker: UIImagePickerController {
        return UIImagePickerController(color: UIColor.white)
    }
}
