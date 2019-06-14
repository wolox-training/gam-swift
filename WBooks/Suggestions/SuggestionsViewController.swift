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
    
    private func configureCarousel() {
        _viewModel.state.producer.startWithValues { [weak self] state in
            if let this = self {
                switch state {
                case .loading:
                    break
                    //TODO Start Activity Indicator
                case .error, .empty:
                    break
                    //TODO: Display no suggestions available
                    //TODO Stop Activity Indicator
                case .withValues:
                    //TODO Stop Activity Indicator
                    print("SUCCESS")
                    this._view.suggestionCollectionView.reloadData()
                }
            }
            
        }
        _view.suggestionCollectionView.dataSource = self
        _viewModel.loadSuggestions()
    }
}

extension SuggestionsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _viewModel.covers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = _view.suggestionCollectionView.dequeue(cell: SuggestionCell.self, for: indexPath)!
        cell.setCover(cover: _viewModel.covers[indexPath.item])
        return cell
    }
}
