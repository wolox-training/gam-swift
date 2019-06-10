//
//  AddNewController.swift
//  WBooks
//
//  Created by Gaston Maspero on 24/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import UIKit
import ReactiveSwift

class AddNewController: UIViewController {
    
    private lazy var _view: AddNewView = AddNewView.loadFromNib()!
    
    override func loadView() {
        view = _view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _view.setView()
        setImagePicker()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavBar()
    }
    
    private func setImagePicker() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        tapRecognizer.delegate = self
        _view.cover.addGestureRecognizer(tapRecognizer)
        _view.cover.isUserInteractionEnabled = true
    }
    
    @objc private func imageTapped(sender: AnyObject) {
        print("Image tapped!")
    }

    private func configureNavBar() {
        self.tabBarController?.setNavigationBarTitle("NAVIGATION_BAR_TITLE_ADD_NEW".localized(), font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.medium), color: UIColor.white)
        //Left notification button
        self.tabBarController?.navigationItem.leftBarButtonItem = nil
        //Right search button
        self.tabBarController?.navigationItem.rightBarButtonItem = nil
    }
}

extension AddNewController: UIImagePickerControllerDelegate {
    
}

extension AddNewController: UIGestureRecognizerDelegate {
    
}
