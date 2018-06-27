//
//  APIConstants.swift
//  KreativeTest
//
//  Created by thejus manoharan on 26/06/2018.
//  Copyright © 2018 thejus. All rights reserved.
//

import Foundation
import SwiftyJSON

internal struct APIBasePath {
    

    static let basePath = "https://www.omdbapi.com/"
    
}

internal struct APITypes {
    

    static let getMovieDetails = ""
    static let getMovieList = ""
    
}

enum APIConstants:String {
    
    case success = "success"
    case message = "message"
}



enum Validate : String {
    
    case none
    case success = "1"
    case failure = "0"
    
    func map(response message : String?) -> String? {
        
        switch self {
            
        case .success:
            return message
            
        case .failure :
            return message
            
        default:
            return nil
        }
    }
}

enum Response {
    case success(JSON)
    case failure(String?)
}

typealias OptionalDictionary = [String : Any]?


