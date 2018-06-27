//
//  APIHandler.swift
//  KreativeTest
//
//  Created by thejus manoharan on 26/06/2018.
//  Copyright © 2018 thejus. All rights reserved.
//
import Foundation
import ObjectMapper


//<-----------------------------MOVIES CUSTOM END POINT------------------------------->

extension MoviesEndPoints {
    
    func handle(data : Any) -> AnyObject? {
        
        switch self {
            
        case .getMovieDetails(_):
            
            let object  = Mapper<Movies>().map(JSONObject: data)
            return object
        
        case .getMovieList(_):
            
            let object  = Mapper<Movies>().map(JSONObject: data)
            return object
            
            
        default:
            return data as AnyObject
        }
    }
    
}




