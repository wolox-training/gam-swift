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
        _viewModel.loadSuggestions()
        _view.suggestionCollectionView.dataSource = self
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
