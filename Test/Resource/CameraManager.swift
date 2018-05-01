//
//  CameraManager.swift
//  Muhameek
//
//  Created by Sierra 4 on 22/07/17.
//  Copyright © 2017 monika. All rights reserved.
//

import UIKit
import AVFoundation
import MobileCoreServices

class CameraManager: NSObject , UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    typealias onPicked = (Any) -> ()
    typealias onCanceled = () -> ()
    
    
    var pickedListner : onPicked?
    var canceledListner : onCanceled?
    
    static let sharedInstance = CameraManager()
    
    override init(){
        super.init()
        
    }
    
    deinit{
        
    }
   
    
    func pickerImage(image : Bool = true, type : String? , presentInVc : UIViewController , pickedListner : @escaping onPicked , canceledListner : @escaping onCanceled){
        
        self.pickedListner = pickedListner
        self.canceledListner = canceledListner
        
        let picker : UIImagePickerController = UIImagePickerController()
        picker.sourceType = /type == "Camera" ? UIImagePickerControllerSourceType.camera : UIImagePickerControllerSourceType.photoLibrary
        picker.delegate = self
        picker.allowsEditing = false
//        picker.mediaTypes = image ? ["public.image", "public.movie"] : [kUTTypeMovie as String]
        presentInVc.present(picker, animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        if let listener = canceledListner{
            listener()
        }
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let image : UIImage = info[UIImagePickerControllerOriginalImage] as? UIImage , let listener = pickedListner{
//           let fixOrientationImage = image.fixOrientation()
            listener(image)
        }
//        if let pickedVideo: URL = (info[UIImagePickerControllerMediaURL]) as? URL, let listener = pickedListner {
//              listener(pickedVideo)
//        }
    }
    
    
    
    
}
