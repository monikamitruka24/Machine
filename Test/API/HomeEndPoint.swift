//
//  HomeEndPoint.swift
//  Test
//
//  Created by Sierra 4 on 01/05/18.
//  Copyright © 2017 monika. All rights reserved.
//
import Foundation
import UIKit
import Alamofire

enum HomeEndpoint {
    case register(email : String?,password : String?)
    case login(email : String?,password : String?)
    case usersList()
}


extension HomeEndpoint : Router {
    
    var route : String  {
        
        switch self {
        case .register(_) : return APIConstants.register
        case .login(_) : return APIConstants.login
        case .usersList() : return APIConstants.usersList
            
        }
    }
    
    var parameters: OptionalDictionary{
        return format()
    }
    
    
    func format() -> OptionalDictionary {
        
        switch self {
            
        case .usersList() :
            return nil
            
        case .register(let email,let password),.login(let email,let password) :
               return Parameters.register.map(values : [email,password])
            
        }
        
    }
    
    var method : Alamofire.HTTPMethod {
        switch self {
        case .usersList() :
            return .get
        default:
            return .post
        }
    }
    
    var baseURL: String{
        return APIConstants.basePath
    }
    
}

