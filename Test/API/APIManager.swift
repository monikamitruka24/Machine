//
//  APIManager.swift
//  Test
//
//  Created by Sierra 4 on 01/05/18.
//  Copyright © 2017 monika. All rights reserved.
//
import Foundation
import SwiftyJSON
import NVActivityIndicatorView

class APIManager: NSObject , NVActivityIndicatorViewable{
    
    typealias Completion = (Response) -> ()
    static let shared = APIManager()
    private lazy var httpClient : HTTPClient = HTTPClient()
    
    func request(with api : Router , completion : @escaping Completion )  {
        
        if isLoaderNeeded(api: api) {
            Utility.shared().window?.rootViewController?.startAnimating(nil, message: nil, messageFont: nil, type: .lineScalePulseOutRapid, color: UIColor.red(), padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil)
        }
        
        httpClient.postRequest(withApi: api, success: { (data) in
            Utility.shared().window?.rootViewController?.stopAnimating()
            
            guard let response = data else {
                completion(Response.failure(.none))
                return
            }
            let json = JSON(response)
            print(json)
              let responseType =   Validate.success 
            
            switch responseType {
            case .success:
                let object : AnyObject?
                object = api.handle(parameters: json)
                completion(Response.success(object))
                
            case .failure:
                if json[APIConstants.message].stringValue == "Token expired! Please login to continue!" {
                    
                    let str = "Token expired! Please login to continue!"
                    self.moveOut(str : str)
                }else {
                    completion(Response.failure(json[APIConstants.message].stringValue as Any ))
                }
                
            default :
                break
            }
        }, failure: { (message) in
            
            Utility.shared().window?.rootViewController?.stopAnimating()
            completion(Response.failure(message as Any ))
            //completion(Response.failure(.failure))
        })
        
    }
    
    func request (withImages api : Router , images : [UIImage]?  , completion : @escaping Completion )  {
        
        if isLoaderNeeded(api: api) {
            Utility.shared().window?.rootViewController?.startAnimating(nil, message: nil, messageFont: nil, type: .lineScalePulseOutRapid, color: UIColor.red(), padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil)
        }
        
        httpClient.postRequestWithImages(withApi: api, images: images, success: {[weak self] (data) in
            
            Utility.shared().window?.rootViewController?.stopAnimating()
            guard let response = data else {
                completion(Response.failure(.none))
                return
            }
            let json = JSON(response)
            print(json)
            
            let responseType =   Validate.success
            
            switch responseType {
            case .success:
                let object : AnyObject?
                object = api.handle(parameters: json)
                completion(Response.success(object))
                
            case .failure:
                if json[APIConstants.message].stringValue == "Token expired! Please login to continue!" {
                    
                    let str = "Token expired! Please login to continue!"
                    self?.moveOut(str : str)
                }else {
                    completion(Response.failure(json[APIConstants.message].stringValue as Any ))
                }

                
            default :
                break
            }
            
            }, failure: { (message) in
                
                Utility.shared().window?.rootViewController?.stopAnimating()
                completion(Response.failure(message as Any))
                
        })
    }

    
    func isLoaderNeeded(api : Router) -> Bool{
        
        switch api.route {
        
        default:
            return true
        }
    }
    
}

extension APIManager {
    
    func moveOut(str : String) {
        
    }
}

