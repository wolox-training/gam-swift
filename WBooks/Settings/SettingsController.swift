//
//  SettingsController.swift
//  WBooks
//
//  Created by Gaston Maspero on 24/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import UIKit

class SettingsController: UIViewController {

    private lazy var _view: SettingsView = SettingsView.loadFromNib()!
    
    override func loadView() {
        view = _view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _view.setView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavBar(title: "NAVIGATION_BAR_TITLE_SETTINGS".localized())
    }
}
