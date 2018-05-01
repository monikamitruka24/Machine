//
//  APIHandler.swift
//  Test
//
//  Created by Sierra 4 on 01/05/18.
//  Copyright © 2017 monika. All rights reserved.
//

import Foundation
import SwiftyJSON

enum ResponseKeys : String {
    case user = "user"
    case data = "data"
    case countries = "countries"
    case message = "message"
}



extension HomeEndpoint {
    
    func handle(parameters : JSON) -> AnyObject? {
        print(parameters)
        switch self {
       
        case .register(_), .login(_) :
            return parameters["token"].stringValue as AnyObject
       
        case .usersList() :
            return UserListData(attributes: parameters.dictionaryValue)
        default :
            return nil
            
        }
        return nil
    }
    
}

extension ImageEndPoint {
    func handle(parameters : JSON) -> AnyObject? {
        print(parameters)
        switch self {
        
        case .editImage(_) :
            return parameters["th_url"].stringValue as AnyObject
        default :
            return nil
            
        }
        return nil
    }
}

