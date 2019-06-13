//
//  RepositoryBuilder.swift
//  WBooks
//
//  Created by Gaston Maspero on 12/06/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation
import Networking

class RepositoryBuilder {
    static var defaultNetworkingConfiguration: NetworkingConfiguration {
        var config = NetworkingConfiguration()
        config.domainURL = "swift-training-backend.herokuapp.com"
        return config
    }
    
    static func getDefaultBookRepository() -> BookRepository {
        return BookRepository(configuration: RepositoryBuilder.defaultNetworkingConfiguration,
                              defaultHeaders: ["Content-Type": "application/json",
                                               "Accept": "application/json"])
    }
    
    static func getDefaultRentsRepository() -> RentsRepository {
        return RentsRepository(configuration: RepositoryBuilder.defaultNetworkingConfiguration,
                              defaultHeaders: ["Content-Type": "application/json",
                                               "Accept": "application/json"])
    }
    
    static func getDefaultCommentsRepository() -> CommentsRepository {
        return CommentsRepository(configuration: RepositoryBuilder.defaultNetworkingConfiguration,
                              defaultHeaders: ["Content-Type": "application/json",
                                               "Accept": "application/json"])
    }
}
