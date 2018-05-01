//
//  APIConstants.swift
//  Test
//
//  Created by Sierra 4 on 01/05/18.
//  Copyright © 2017 monika. All rights reserved.
//

import Foundation
internal struct RegexExpresssions {
    
    static let EmailRegex = "[A-Z0-9a-z._%+-]{3,}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
    static let PasswordRegex = "[A-Za-z0-9]{6,20}"
    static let PhoneRegex = "[0-9]{6,14}"
    static let OtpRegex = "[0-9]{3,14}"
    
}

internal struct APIConstants {
   static let basePath = "https://reqres.in/api/"
static let imagePath = "https://api.pixhost.to/"
 
    static let message = "msg"
    static let success = "success"
    
    
   static let register = "register"
    static let login = "login"
    static var usersList = "users?page="
    static let editImage = "images"
    
    
}

enum Keys : String{
    
    //User LoginProcess Keys
  case contentType = "content_type"
   case max_th_size = "max_th_size"
    case email = "email"
   case password = "password"
}




enum Validate : String {
    
    case none
    case success = "1"
    case failure = "0"
    case invalidAccessToken = "2"
    case fbLogin = "3"
    
    func map(response message : String?) -> String? {
        
        switch self {
        case .success:
            return message
        case .failure :
            return message
        case .invalidAccessToken :
            return message
            
        default:
            return nil
        }
        
    }
}

enum Response {
    case success(AnyObject?)
    case failure(Any?)
}

typealias OptionalDictionary = [String : Any]?

struct Parameters {
    
    static let register  : [Keys] = [.email,.password]
    static let editImage : [Keys] = [.contentType ,.max_th_size]

}

