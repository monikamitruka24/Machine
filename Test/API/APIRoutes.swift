////
////  APIRoutes.swift
////  Test
////
////  Created by Sierra 4 on 05/05/18.
////  Copyright © 2017 monika. All rights reserved.
////
//
import Foundation
import Alamofire
import SwiftyJSON

protocol Router {
    var route : String { get }
    var baseURL : String { get }
    var parameters : OptionalDictionary { get }
    var method : Alamofire.HTTPMethod { get }
    func handle(parameters : JSON) -> AnyObject?
}

extension Sequence where Iterator.Element == Keys {
    
    func map(values: [Any?]) -> OptionalDictionary {
        
        var params = [String : Any]()
        
        for (index,element) in zip(self,values) {
            params[index.rawValue] = element 
        }
        return params
        
    }
}
