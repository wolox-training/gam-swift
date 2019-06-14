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
        suggestionsRepository.fetchSuggestions().startWithResult { [weak self] result in
            guard let this = self else {
                return
            }
            switch result {
            case .success(let resultArray):
                print("====================")
                print(resultArray)
                print("====================")
                this.suggestions = resultArray
                this.loadCovers()
                this.state.value = resultArray.isEmpty ? .empty : .withValues
            case .failure(let error):
                this.state.value = .error
                print(error)
            }
        }
    }
    
    private func loadCovers() {
        covers = suggestions.filter { suggestion in
            return URL(string: suggestion.link) != nil
            }.map { suggestion in
                var image: UIImage = UIImage(named: "no_image_available")!
                let url = URL(string: suggestion.link)
                if let url = url {
                    do {
                        let data = try Data(contentsOf: url)
                        image = UIImage(data: data)!
                    } catch {
                        print("No image available for book.")
                    }
                }
                return image
        }
    }
}
