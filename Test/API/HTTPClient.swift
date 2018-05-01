//
//  HTTPClient.swift
//  Test
//
//  Created by Sierra 4 on 01/05/18.
//  Copyright © 2017 monika. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

typealias HttpClientSuccess = (Any?) -> ()
typealias HttpClientFailure = (String) -> ()


class HTTPClient {
    
    static var imageName = ["licensePhoto", "profilePic"]
    static var withDocFileName = "files"
    static func getHeader(contentType : Bool = false) -> [String : String]? {
            return nil

    }
    
    
    func JSONObjectWithData(data: NSData) -> Any? {
        do { return try JSONSerialization.jsonObject(with: data as Data, options: []) }
        catch { return .none }
    }
    
    func postRequest(withApi api : Router  , success : @escaping HttpClientSuccess , failure : @escaping HttpClientFailure ){
        
        let params = api.parameters
        let fullPath = api.baseURL + api.route
        let method = api.method
        print(fullPath)
        print(params)
        
        
        
        Alamofire.request(fullPath, method: method, parameters: params, encoding: URLEncoding.default, headers: HTTPClient.getHeader() ).responseJSON { (response) in
            
            switch response.result {
            case .success(let data):
                success(data)
            case .failure(let error):
                failure(error.localizedDescription)
            }
        }
        
    }
    
    func postRequestWithImages(withApi api : Router,images : [UIImage]?, success : @escaping HttpClientSuccess , failure : @escaping HttpClientFailure){
        
        guard let params = api.parameters else {failure("empty"); return}
        let fullPath = api.baseURL + api.route
        print(fullPath)
        print(params)
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            if let arrayImages = images{
                for (i, image) in arrayImages.enumerated() {
                    
                    guard let imageData = UIImageJPEGRepresentation(image, 0.5) else {
                        return }
                    
                    multipartFormData.append(imageData, withName: "img", fileName: "photo.jpeg", mimeType: "image/jpg")
                }
            }
            if  let params =  api.parameters {
                print(params)
                for (key, value) in params {
                    multipartFormData.append(((value) as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                }
            }
            
        }, to: fullPath,headers: HTTPClient.getHeader()) { (encodingResult) in
            switch encodingResult {
            case .success(let upload,_,_):
                
                upload.responseJSON { response in
                    switch response.result {
                    case .success(let data):
                        success(data)
                    case .failure(let error):
                        failure(error.localizedDescription)
                    }
                }
                
            case .failure(let encodingError):
                print(encodingError)
            }
        }
    }
    
   
}


