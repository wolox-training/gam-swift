//
//  StartingViewController.swift
//  WBooks
//
//  Created by Gaston Maspero on 22/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import UIKit
import WolmoCore

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
        setAction()
        super.viewDidLoad()
    }
    
    func setAction() {
        _view.signInGoogleButton.addTarget(self, action: #selector(signIn), for: .touchUpInside)
    }
    
    @objc func signIn() {
        print("Hello Wolox!")
        let controller = UINavigationController(rootViewController: MainMenuController())
        present(controller, animated: true)
    }
}
