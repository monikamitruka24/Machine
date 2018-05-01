//
//  ImageEndPoint.swift
//  Test
//
//  Created by Sierra 4 on 01/05/18.
//  Copyright © 2017 monika. All rights reserved.
//
import Foundation
import UIKit
import Alamofire

enum ImageEndPoint {

    case editImage(contentType : String? ,maxSize : String?)
}


extension ImageEndPoint : Router {
    
    var route : String  {
        
        switch self {
  
             case .editImage(_) : return APIConstants.editImage
            
        }
    }
    
    var parameters: OptionalDictionary{
        return format()
    }
    
    
    func format() -> OptionalDictionary {
        
        switch self {
            
        case .editImage(let contentType , let maxSize) :
            return Parameters.editImage.map(values : [contentType,maxSize])
            
       
            
        }
        
    }
    
    var method : Alamofire.HTTPMethod {
        switch self {
    
        default:
            return .post
        }
    }
    
    var baseURL: String{
        return APIConstants.imagePath
    }
    
}


