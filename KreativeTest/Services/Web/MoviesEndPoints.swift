//
//  MoviesEndPoints.swift
//  KreativeTest
//
//  Created by thejus manoharan on 26/06/2018.
//  Copyright © 2018 thejus. All rights reserved.
//

import Foundation

import UIKit
import Alamofire
import ObjectMapper

enum MoviesEndPoints {
    
//    case getAllData()
    case getMovieDetails(imdbID : String)
    case getMovieList(searchKeyword : String, pageNo : Int, movieType : String)
}

extension MoviesEndPoints: Router {
    
   
    var route: String  {
        
        switch self {
            
        case.getMovieDetails(_): return APITypes.getMovieDetails
        case.getMovieList(_): return APITypes.getMovieList
            
        }
    }
    
    var parameters: OptionalDictionary {
        switch self {
            
        case .getMovieList(let searchKeyword, let pageNo, let movieType): return ["apikey":"15d0d139","s" : searchKeyword,"page":pageNo,"type":movieType]
        case .getMovieDetails(let imdbID) : return ["apikey":"15d0d139","i" : imdbID]
        }
    }
    
    var method: Alamofire.HTTPMethod {
        
        switch self {
            
        default:
            return .get
        }
    }
    
    var baseURL: String{
        return APIBasePath.basePath
    }
}
