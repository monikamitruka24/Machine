//
//  Utility.swift
//  cozo
//
//  Created by Sierra 4 on 05/05/17.
//  Copyright © 2017 monika. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import EZSwiftExtensions
import SwiftyJSON
import Photos

class Utility: NSObject, NVActivityIndicatorViewable {
    
    static let functions = Utility()
    
    static func shared() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
        
    }
    
    
    func loader()  {
        Utility.shared().window?.rootViewController?.startAnimating(nil, message: nil, messageFont: nil, type: .lineScalePulseOutRapid, color: UIColor.red(), padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil)
    }
    
    func removeLoader()  {
        Utility.shared().window?.rootViewController?.stopAnimating()
    }
    
    class func isCameraPermission() -> Bool{
        let cameraMediaType = AVMediaType.video
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: cameraMediaType)
        switch cameraAuthorizationStatus {
        case .authorized: return true
        case .restricted: return false
        case .denied: return false
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (granted) in
                
            })
            return true
        }
    }
    
    class func accessToPhotos()->Bool{
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized: return true
        case .restricted: return false
        case .denied: return false
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({ (newStatus) in
                if (newStatus == PHAuthorizationStatus.authorized) {}else {}
            })
            return true
        }
    }
    
}


