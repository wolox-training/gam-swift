//
//  RentalsView.swift
//  WBooks
//
//  Created by Gaston Maspero on 14/06/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import UIKit
import WolmoCore

class RentalsView: UIView, NibLoadable {
    
    var suggestionsView: UIView?
    var rentedBooksView: UIView?
    let suggestionsLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
    let margin: CGFloat = 20
    
    func setView(suggestionsView: UIView, rentedBooksView: UIView) {
        self.suggestionsView = suggestionsView
        self.rentedBooksView = rentedBooksView
        
        self.backgroundColor = UIColor.wBooksBackground
        
        addSubview(rentedBooksView)
        addSubview(suggestionsView)
        addSubview(suggestionsLabel)
        
        setSuggestionsLabel()        
    }
    
    private func setSuggestionsLabel() {
        suggestionsLabel.font = UIFont.systemFont(ofSize: 18, weight: .black)
        suggestionsLabel.textColor = .black
        suggestionsLabel.textAlignment = .left
        suggestionsLabel.text = "SUGGESTIONS".localized()
        suggestionsLabel.translatesAutoresizingMaskIntoConstraints = false
    }
}
