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
    
    private let _formFilled = MutableProperty(false)
    private var _loading = false
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
        configureAddNewNavBar()
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
            text.isNotEmpty
        }
        let authorValidation = _view.author.reactive.continuousTextValues.skipNil().map { text in
            text.isNotEmpty
        }
        let yearValidation = _view.year.reactive.continuousTextValues.skipNil().map {text in
            text.isNotEmpty
        }
        let genreValidation = _view.genre.reactive.continuousTextValues.skipNil().map {text in
            text.isNotEmpty
        }
        let descriptionValidation = _view.bookDescription.reactive.continuousTextValues.skipNil().map {text in
            text.isNotEmpty
        }
        let isButtonEnabled = Signal<Bool, NoError>.combineLatest(bookNameValidation, authorValidation, yearValidation, genreValidation, descriptionValidation).map {
            $0 && $1 && $2 && $3 && $4
        }
        
        isButtonEnabled.observeValues { [weak self] value in
            self?._formFilled.value = value
        }
    }
    
    private func setSubmitButton() {
        _formFilled.producer.startWithValues { [weak self] formFilled in
            if let this = self {
                if formFilled && !this._loading {
                    this._view.enableSubmit()
                } else {
                    this._view.disableSubmit()
                }
            }
        }
        _view.submitButton.reactive.controlEvents(.touchUpInside).observeValues { [weak self] _ in
            self?._loading = true
            self?._view.disableSubmit()
            self?._view.disableInteractions()
            self?.submit()
        }
    }
    
    func submit() {
        _viewModel.addBook(onSuccess: onAddNewSuccess, onError: onError)
    }
    
    func onAddNewSuccess() {
        _loading = false
        _view.resetForm()
        _view.enableInteractions()
        let alert = UIAlertController(alertViewModel: ErrorAlertViewModel(title: "THANKS".localized(), message: "BOOK_ADDED".localized(), dismissButtonTitle: "ACCEPT".localized()))
        self.present(alert, animated: true, completion: nil)
    }
    
    func onError(error: Error) {
        _loading = false
        _view.enableSubmit()
        _view.enableInteractions()
        let alert = UIAlertController(alertViewModel: ErrorAlertViewModel(title: "UPS".localized(), message: "BOOK_ADD_ERROR".localized(), dismissButtonTitle: "ACCEPT".localized()))
        self.present(alert, animated: true, completion: nil)
        print(error)
    }
    
    private func setImagePicker() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        _view.cover.addGestureRecognizer(tapRecognizer)
        _view.cover.isUserInteractionEnabled = true
    }
    
    @objc private func imageTapped(sender: AnyObject) {
        let alertController = UIAlertController(title: .none, message: .none, preferredStyle: .actionSheet)
        
        //Gallery option
        let chooseAction = UIAlertAction(title: "GALLERY".localized(), style: .default) { [weak self] _ in
            let imagePickerController = UIImagePickerController.imagePicker
            imagePickerController.delegate = self
            imagePickerController.sourceType = .photoLibrary
            self?.present(imagePickerController, animated: true, completion: .none)
        }
        //Camera option
        let takeAction = UIAlertAction(title: "CAMERA".localized(), style: .default) { [weak self] _ in
            let imagePickerController = UIImagePickerController.imagePicker
            imagePickerController.delegate = self
            imagePickerController.sourceType = .camera
            self?.present(imagePickerController, animated: true, completion: .none)
        }
        
        //Cancel option
        let cancelAction = UIAlertAction(title: "CANCEL".localized(), style: .cancel, handler: .none)
        
        alertController.addAction(takeAction)
        alertController.addAction(chooseAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}

extension AddNewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        _view.cover.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        dismiss(animated: true, completion: nil)
    }
}
