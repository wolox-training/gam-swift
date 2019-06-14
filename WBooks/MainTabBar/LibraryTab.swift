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
        setNeedsStatusBarAppearanceUpdate()
        configureTabBar()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func configureTabBar() {
        tabBar.barTintColor = .white
        let bookController = BookTableController(viewModel: LibraryViewModel())
        let library = LibraryViewController(booksController: bookController)
        bookController.setSuperViewController(superViewController: library)
        library.tabBarItem = UITabBarItem()
        library.tabBarItem.title = "TAB_BAR_LIBRARY".localized()
        library.tabBarItem.image = UIImage.libraryImage
        library.tabBarItem.tag = 0
        
        let wishList = WishListController()
        wishList.tabBarItem = UITabBarItem()
        wishList.tabBarItem.title = "TAB_BAR_WISHLIST".localized()
        wishList.tabBarItem.image = UIImage.wishListImage
        wishList.tabBarItem.tag = 1
        
        let addNew = AddNewController()
        addNew.tabBarItem = UITabBarItem()
        addNew.tabBarItem.title = "TAB_BAR_ADD_NEW".localized()
        addNew.tabBarItem.image = UIImage.addNewImage
        addNew.tabBarItem.tag = 2
        
        let rentBookController = BookTableController(viewModel: RentalsViewModel())
        let suggestionsController = SuggestionsViewController(viewModel: SuggestionsViewModel())
        let rentals = RentalsController(booksController: rentBookController, suggestionsController: suggestionsController)
        rentBookController.setSuperViewController(superViewController: rentals)
        rentals.tabBarItem = UITabBarItem()
        rentals.tabBarItem.title = "TAB_BAR_RENTALS".localized()
        rentals.tabBarItem.image = UIImage.myRentalsImage
        rentals.tabBarItem.tag = 3
        
        let settings = SettingsController()
        settings.tabBarItem = UITabBarItem()
        settings.tabBarItem.title = "TAB_BAR_SETTINGS".localized()
        settings.tabBarItem.image = UIImage.settingsImage
        settings.tabBarItem.tag = 4
        
        viewControllers = [library, wishList, addNew, rentals, settings]
    }
}
