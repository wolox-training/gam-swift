//
//  Colors.swift
//  WBooks
//
//  Created by Gaston Maspero on 06/06/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    static var wBooksBlue: CGColor {
        return UIColor(red: 73/255, green: 194/255, blue: 1, alpha: 1).cgColor
    }
    
    static var wBooksBackground: UIColor {
        return UIColor(red: 236/255, green: 246/255, blue: 249/255, alpha: 1)
    }
    
    static var wBooksLeftGradientColor: UIColor {
        return UIColor(red: 0/255, green: 165/255, blue: 233/255, alpha: 1)
    }
    
    static var wBooksRightGradientColor: UIColor {
        return UIColor(red: 48/255, green: 196/255, blue: 198/255, alpha: 1)
    }
    
    static var wBooksPlaceholderGray: UIColor {
        return UIColor(red: 204/255, green: 204/255, blue: 209/255, alpha: 1)
    }
}
