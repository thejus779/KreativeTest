//
//  Movies.swift
//  KreativeTest
//
//  Created by thejus manoharan on 26/06/2018.
//  Copyright © 2018 thejus. All rights reserved.
//

import Foundation
import SwiftyJSON
import ObjectMapper

class Movies: Mappable {
    var Title : String?
    var Year : String?
    var imdbID : String?
    var movieType : String?
    var Poster : String?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        imdbID      <- map["imdbID"]
        Title       <- map["Title"]
        Year        <- map["Year"]
        movieType   <- map["Type"]
        Poster      <- map["Poster"]
        
    }
}

class MovieDetails: Mappable {
    var Title : String?
    var Year : String?
    var imdbID : String?
    var movieType : String?
    var Poster : String?
    var Genre : String?
    var Director : String?
    var Actors : String?
    var Language : String?
    var imdbRating : String?
    var Plot : String?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        imdbID      <- map["imdbID"]
        Title       <- map["Title"]
        Year        <- map["Year"]
        movieType   <- map["Type"]
        Poster      <- map["Poster"]
        Genre       <- map["Genre"]
        Director    <- map["Director"]
        Actors      <- map["Actors"]
        Language    <- map["Language"]
        imdbRating  <- map["imdbRating"]
        Plot        <- map["Plot"]
    }
}
