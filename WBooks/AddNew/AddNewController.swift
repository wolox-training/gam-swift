//
//  AddNewController.swift
//  WBooks
//
//  Created by Gaston Maspero on 24/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa
import Result
import WolmoCore

class AddNewController: UIViewController {
    
    private let formFilled = MutableProperty(false)
    
    private var loading = false
    
    private lazy var _view: AddNewView = AddNewView.loadFromNib()!
    
    private var _viewModel: AddNewViewModel = AddNewViewModel()
    
    override func loadView() {
        view = _view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _view.setView()
        setBindings()
        setFormValidation()
        setSubmitButton()
        setImagePicker()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavBar()
    }
    
    private func setBindings() {
        _viewModel.bookName <~ _view.booksName.reactive.continuousTextValues.skipNil()
        _viewModel.author <~ _view.author.reactive.continuousTextValues.skipNil()
        _viewModel.year <~ _view.year.reactive.continuousTextValues.skipNil()
        _viewModel.genre <~ _view.genre.reactive.continuousTextValues.skipNil()
        _viewModel.descrpition <~ _view.bookDescription.reactive.continuousTextValues.skipNil()
    }
    
    private func setFormValidation() {
        let bookNameValidation = _view.booksName.reactive.continuousTextValues.skipNil().map { text in
            !text.isEmpty
        }
        let authorValidation = _view.author.reactive.continuousTextValues.skipNil().map { text in
            !text.isEmpty
        }
        let yearValidation = _view.year.reactive.continuousTextValues.skipNil().map {text in
            !text.isEmpty
        }
        let genreValidation = _view.genre.reactive.continuousTextValues.skipNil().map {text in
            !text.isEmpty
        }
        let descriptionValidation = _view.bookDescription.reactive.continuousTextValues.skipNil().map {text in
            !text.isEmpty
        }
        let isButtonEnabled = Signal<Bool, NoError>.combineLatest(bookNameValidation, authorValidation, yearValidation, genreValidation, descriptionValidation).map {
            $0 && $1 && $2 && $3 && $4
        }
        
        isButtonEnabled.observeValues { [weak self] value in
            self?.formFilled.value = value
        }
    }
    
    private func setSubmitButton() {
        formFilled.producer.startWithValues { [weak self] formFilled in
            if let this = self {
                if formFilled && !this.loading {
                    this._view.enableSubmit()
                } else {
                    this._view.disableSubmit()
                }
            }
        }
        _view.submitButton.reactive.controlEvents(.touchUpInside).observeValues { [weak self] _ in
            self?.loading = true
            self?._view.disableSubmit()
            self?._view.disableInteractions()
            self?.submit()
        }
    }
    
    func submit() {
        _viewModel.addBook(onSuccess: onAddNewSuccess, onError: onError)
    }
    
    func onAddNewSuccess() {
        loading = false
        _view.resetForm()
        _view.enableInteractions()
        let alert = UIAlertController(alertViewModel: ErrorAlertViewModel(title: "THANKS".localized(), message: "BOOK_ADDED".localized(), dismissButtonTitle: "ACCEPT".localized()))
        self.present(alert, animated: true, completion: nil)
    }
    
    func onError(error: Error) {
        loading = true
        _view.enableSubmit()
        _view.enableInteractions()
        let alert = UIAlertController(alertViewModel: ErrorAlertViewModel(title: "UPS".localized(), message: "BOOK_ADD_ERROR".localized(), dismissButtonTitle: "ACCEPT".localized()))
        self.present(alert, animated: true, completion: nil)
        print(error)
    }
    
    private func setImagePicker() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        tapRecognizer.delegate = self
        _view.cover.addGestureRecognizer(tapRecognizer)
        _view.cover.isUserInteractionEnabled = true
    }
    
    @objc private func imageTapped(sender: AnyObject) {
        let alertController = UIAlertController(title: .none, message: .none, preferredStyle: .actionSheet)
        
        //Gallery option
        let chooseAction = UIAlertAction(title: "Gallery", style: .default) { [weak self] _ in
            let imagePickerController = UIImagePickerController.imagePicker
            imagePickerController.delegate = self
            imagePickerController.sourceType = .photoLibrary
            self?.present(imagePickerController, animated: true, completion: .none)
        }
        //Camera option
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let takeAction = UIAlertAction(title: "Camera", style: .default) { [weak self] _ in
                let imagePickerController = UIImagePickerController.imagePicker
                imagePickerController.delegate = self
                imagePickerController.sourceType = .camera
                self?.present(imagePickerController, animated: true, completion: .none)
            }
            alertController.addAction(takeAction)
        }
        //Cancel option
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: .none)
        
        alertController.addAction(chooseAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
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
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        _view.cover.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        dismiss(animated: true, completion: nil)
    }
}

extension AddNewController: UINavigationControllerDelegate {
}

extension AddNewController: UIGestureRecognizerDelegate {
}
