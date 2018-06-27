//
//  APIRoutes.swift
//  KreativeTest
//
//  Created by thejus manoharan on 26/06/2018.
//  Copyright © 2018 thejus. All rights reserved.
//
import Foundation
import ObjectMapper
import Alamofire

protocol Router {
  
  var route: String { get }
  var baseURL: String { get }
  var method: Alamofire.HTTPMethod { get }
  var parameters: OptionalDictionary { get }
    
  func handle(data: Any) -> AnyObject?
}

