//
//  WishListController.swift
//  WBooks
//
//  Created by Gaston Maspero on 24/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import UIKit

class WishListController: UIViewController {
    
    private lazy var _view: WishListView = WishListView.loadFromNib()!
    
    override func loadView() {
        view = _view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _view.setView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavBar()
    }
    
    private func configureNavBar() {
        self.tabBarController?.setNavigationBarTitle("NAVIGATION_BAR_TITLE_WISHLIST".localized(), font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.medium), color: UIColor.white)
        //Left notification button
        self.tabBarController?.navigationItem.leftBarButtonItem = nil
        //Right search button
        self.tabBarController?.navigationItem.rightBarButtonItem = nil
    }
}
