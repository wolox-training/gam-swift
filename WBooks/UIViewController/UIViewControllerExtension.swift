//
//  NavigationControllerExtension.swift
//  WBooks
//
//  Created by Gaston Maspero on 12/06/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func configureNavBar(title: String) {
        tabBarController?.setNavigationBarTitle(title, font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.medium), color: UIColor.white)
        //Left notification button
        tabBarController?.navigationItem.leftBarButtonItem = nil
        //Right search button
        tabBarController?.navigationItem.rightBarButtonItem = nil
    }
}
