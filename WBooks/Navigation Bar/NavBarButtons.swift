//
//  NavBarButtons.swift
//  WBooks
//
//  Created by Gaston Maspero on 24/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    static func searchButton() -> UIBarButtonItem {
        let notificationsButton = UIButton(type: .system)
        notificationsButton.setImage(#imageLiteral(resourceName: "ic_notifications").withRenderingMode(.alwaysOriginal), for: .normal)
        notificationsButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        return UIBarButtonItem(customView: notificationsButton)
    }
    
    static func notificationButton() -> UIBarButtonItem {
        let searchButton = UIButton(type: .system)
        searchButton.setImage(#imageLiteral(resourceName: "ic_search.png").withRenderingMode(.alwaysOriginal), for: .normal)
        searchButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        return UIBarButtonItem(customView: searchButton)
    }
    
    static func backNavBarButton(controller: UIViewController) -> UIBarButtonItem {
        let backButton = UIButton(type: .system)
        backButton.setImage(#imageLiteral(resourceName: "ic_back").withRenderingMode(.alwaysOriginal), for: .normal)
        backButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        backButton.reactive.controlEvents(.touchUpInside).observeValues { _ in
            if let currentNavigationController = controller.navigationController {
                currentNavigationController.popViewController(animated: true)
            }
        }
        return UIBarButtonItem(customView: backButton)
    }
}
