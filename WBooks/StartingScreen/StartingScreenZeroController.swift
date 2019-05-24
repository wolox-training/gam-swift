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
    
    @objc func signIn(){
        print("Hello Wolox!")
        let controller = UINavigationController(rootViewController: MainMenuController())
        present(controller, animated: true)
    }
    
    override func loadView() {
        view = _view
    }
    
    override func viewDidLoad() {
        setAction()
        super.viewDidLoad()
    }
    
    @objc func signIn() {
        print("Hello Wolox!")
        let mainViewController = MainMenuController()
        present(mainViewController, animated: true)
    }
    
    func setAction() {
        _view.signInGoogleButton.addTarget(self, action: #selector(signIn), for: .touchUpInside)
    }
}
