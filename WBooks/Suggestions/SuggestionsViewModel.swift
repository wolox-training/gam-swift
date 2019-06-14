//
//  SuggestionsViewModel.swift
//  WBooks
//
//  Created by Gaston Maspero on 13/06/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation
import ReactiveSwift
import UIKit

class SuggestionsViewModel {
    
    let suggestionsRepository = RepositoryBuilder.getDefaultSuggestionsRepository()
    let state = MutableProperty(TableState.loading)
    
    var suggestions = [Suggestion]()
    
    var covers = [UIImage]()
    
    func loadSuggestions() {
        loadCovers()
    }
    
    private func loadCovers() {
        covers.append(#imageLiteral(resourceName: "img_user2"))
        covers.append(#imageLiteral(resourceName: "img_book3"))
        covers.append(#imageLiteral(resourceName: "img_book4"))
        covers.append(#imageLiteral(resourceName: "img_book5"))
        covers.append(#imageLiteral(resourceName: "img_user1"))
        covers.append(#imageLiteral(resourceName: "img_user1"))
        covers.append(#imageLiteral(resourceName: "img_user1"))
        covers.append(#imageLiteral(resourceName: "googlelogin"))
        covers.append(#imageLiteral(resourceName: "img_book6"))
    }
}
