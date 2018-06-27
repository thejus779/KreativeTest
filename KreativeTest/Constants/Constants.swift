//
//  Constants.swift
//  KreativeTest
//
//  Created by thejus manoharan on 26/06/2018.
//  Copyright © 2018 thejus. All rights reserved.
//

import Foundation

struct Constants {
    // Cell identifier
    static let searchCell = "SearchTableViewCell"
    
    // Segue identifier
    static let segueFromMoviesToDetail = "moviesToDetails"
    
    
    // Image Place holders
    static let placeHolder = "placeholder_image"
    
    // Defaault search keyword
    static let searchKeyword = "ab"
    
    
    // Defaault search keyword
    static let all = "all"
    static let movie = "movie"
    static let series = "series"
    static let episode = "episode"
    
    
    // HTTP Erro Messages
    static let msgUnauthorized = "Unauthorized access: 401"
    static let msgServerNotFound = "Server not found: 404"
    static let internatServeError = "Internal server error: 500"
    static let msgErrorWithStatus = "Error with response status:"
    
    static let errorMessage = "Error"
    
}
enum PickType {
    case all
    case movie
    case series
    case episode
    
    func map() -> String? {
        switch self {
    
            case .all:
                return "";
            
            case .movie :
                return "movie";
            case .series:
                return "series";
            
            case .episode :
                return "episode";
            
            default:
                return ""
        }
    }
}



