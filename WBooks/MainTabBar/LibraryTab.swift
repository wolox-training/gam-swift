//
//  LibraryTab.swift
//  WBooks
//
//  Created by Gaston Maspero on 24/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import UIKit

class LibraryTab: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
        addNavBarButtons()
    }
    
    private func addNavBarButtons() {
        title = "NAVIGATION_BAR_TITLE".localized()
        setNavigationBarTitle("NAVIGATION_BAR_TITLE".localized(), font: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.medium), color: UIColor.white)
        //Left notification button
        navigationItem.leftBarButtonItem = UIBarButtonItem.notificationButton()
        //Right search button
        navigationItem.rightBarButtonItem = UIBarButtonItem.searchButton()
    }
    
    private func configureTabBar() {
        tabBar.barTintColor = .white
        let library = MainMenuController()
        library.tabBarItem = UITabBarItem()
        library.tabBarItem.title = "Library"
        library.tabBarItem.image = UIImage(named: "ic_library")
        library.tabBarItem.tag = 0
        
        let wishList = WishListController()
        wishList.tabBarItem = UITabBarItem()
        wishList.tabBarItem.title = "Wishlist"
        wishList.tabBarItem.image = UIImage(named: "ic_wishlist")
        wishList.tabBarItem.tag = 1
        
        let addNew = AddNewController()
        addNew.tabBarItem = UITabBarItem()
        addNew.tabBarItem.title = "Add New"
        addNew.tabBarItem.image = UIImage(named: "ic_add new")
        addNew.tabBarItem.tag = 2
        
        let rentals = RentalsController()
        rentals.tabBarItem = UITabBarItem()
        rentals.tabBarItem.title = "Rentals"
        rentals.tabBarItem.image = UIImage(named: "ic_myrentals")
        rentals.tabBarItem.tag = 3
        
        let settings = SettingsController()
        settings.tabBarItem = UITabBarItem()
        settings.tabBarItem.title = "Settings"
        settings.tabBarItem.image = UIImage(named: "ic_settings")
        settings.tabBarItem.tag = 4
        
        viewControllers = [library, wishList, addNew, rentals, settings]
    }
}
