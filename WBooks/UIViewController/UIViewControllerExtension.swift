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
    
    func configureLibraryNavBar() {
        tabBarController?.setNavigationBarTitle("NAVIGATION_BAR_TITLE_LIBRARY".localized(), font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.medium), color: UIColor.white)
        //Left notification button
        tabBarController?.navigationItem.leftBarButtonItem = UIBarButtonItem.notificationButton()
        //Right search button
        tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem.searchButton()
    }
    
    func configureBookInfoNavBar() {
        setNavigationBarTitle("BOOK_DETAIL".localized(), font: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.medium), color: UIColor.white)
        //Back button
        navigationItem.leftBarButtonItem = UIBarButtonItem.backNavBarButton {
            if let currentNavigationController = self.navigationController {
                currentNavigationController.popViewController(animated: true)
            }
        }
    }
    
    func configureWishlistNavBar() {
        tabBarController?.setNavigationBarTitle("NAVIGATION_BAR_TITLE_WISHLIST".localized(), font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.medium), color: UIColor.white)
        //Left notification button
        tabBarController?.navigationItem.leftBarButtonItem = nil
        //Right search button
        tabBarController?.navigationItem.rightBarButtonItem = nil
    }
    
    func configureAddNewNavBar() {
        tabBarController?.setNavigationBarTitle("NAVIGATION_BAR_TITLE_ADD_NEW".localized(), font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.medium), color: UIColor.white)
        //Left notification button
        tabBarController?.navigationItem.leftBarButtonItem = nil
        //Right search button
        tabBarController?.navigationItem.rightBarButtonItem = nil
    }
    
    func configureRentalsNavBar() {
        tabBarController?.setNavigationBarTitle("NAVIGATION_BAR_TITLE_RENTALS".localized(), font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.medium), color: UIColor.white)
        //Left notification button
        tabBarController?.navigationItem.leftBarButtonItem = nil
        //Right search button
        tabBarController?.navigationItem.rightBarButtonItem = nil
    }
    
    func configureSettingsNavBar() {
        tabBarController?.setNavigationBarTitle("NAVIGATION_BAR_TITLE_SETTINGS".localized(), font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.medium), color: UIColor.white)
        //Left notification button
        tabBarController?.navigationItem.leftBarButtonItem = nil
        //Right search button
        tabBarController?.navigationItem.rightBarButtonItem = nil
    }
}
