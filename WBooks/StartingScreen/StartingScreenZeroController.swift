//
//  StartingViewController.swift
//  WBooks
//
//  Created by Gaston Maspero on 22/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import UIKit
import WolmoCore
import ReactiveCocoa

class StartingScreenZeroController: UIViewController {

    private lazy var _view: StartingScreenZeroView = StartingScreenZeroView.loadFromNib()!
   
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = _view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNeedsStatusBarAppearanceUpdate()
        setSignInButton()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func setSignInButton() {
        _view.signInGoogleButton.reactive.controlEvents(.touchUpInside).observeValues { _ in
            print("Hello Wolox!")
            let controller = UINavigationController(rootViewController: LibraryTab())
            self.present(controller, animated: true)
        }
    }
}

extension UINavigationController {
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
}
