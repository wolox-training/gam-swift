//
//  SuggestionsViewController.swift
//  WBooks
//
//  Created by Gaston Maspero on 13/06/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import UIKit
import WolmoCore

class SuggestionsViewController: UIViewController {
    
    private weak var _superViewController: UIViewController?
    
    private lazy var _view: SuggestionsView = SuggestionsView.loadFromNib()!
    
    private var _viewModel: SuggestionsViewModel
    
    init(viewModel: SuggestionsViewModel) {
        _viewModel = viewModel
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
        configureCarousel()
    }
    
    func setSuperViewController(superViewController: UIViewController) {
        _superViewController = superViewController
    }
    
    private func configureCarousel() {
        setReactiveCarouselSource()
        _viewModel.loadSuggestions()
        _view.suggestionCollectionView.dataSource = self
        _view.suggestionCollectionView.delegate = self
        _view.suggestionCollectionView.register(cell: SuggestionCell.self)
        _view.suggestionCollectionView.showsHorizontalScrollIndicator = false
        _view.suggestionCollectionView.showsVerticalScrollIndicator = false
        
        let cellDimension = CGFloat(60)
        let layout = _view.suggestionCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        if let layout = layout {
            layout.itemSize = CGSize(width: cellDimension, height: cellDimension)
            layout.scrollDirection = .horizontal
        }
    }
    
    private func setReactiveCarouselSource() {
        _viewModel.state.producer.startWithValues { [weak self] state in
            if let this = self {
                switch state {
                case .loading:
                    this._view.startActivityIndicator()
                case .error, .empty:
                    this._view.displayNoSuggestionsIndicator(state: this._viewModel.state.value)
                    this._view.stopActivityIndicator()
                case .withValues:
                    this._view.stopActivityIndicator()
                    this._view.suggestionCollectionView.reloadData()
                }
            }
            
        }
    }
}

extension SuggestionsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _viewModel.suggestedBooks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = _view.suggestionCollectionView.dequeue(cell: SuggestionCell.self, for: indexPath)!
        cell.setCover(book: _viewModel.suggestedBooks[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let superViewController = _superViewController else {
            return
        }
        let bookViewModel = _viewModel.suggestedBooks[indexPath.item]
        let bookInfoViewModel = BookInfoViewModel(bookViewModel: bookViewModel)
        let commentsController = BookCommentsViewController(viewModel: BookCommentsViewModel(bookViewModel: bookViewModel))
        let bookDetailsController = BookDetailsViewController(viewModel: BookDetailsViewModel(bookViewModel: bookViewModel))
        
        let controller = BookInfoViewController(viewModel: bookInfoViewModel, commentsController: commentsController, bookDetailsController: bookDetailsController)
        superViewController.navigationController?.pushViewController(controller, animated: true)
    }
}
