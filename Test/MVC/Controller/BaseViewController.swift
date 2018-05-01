//
//  BaseViewController.swift
//  Test
//
//  Created by Monika on 01/05/18.
//  Copyright © 2018 Monika. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class BaseViewController: UIViewController {
    
    var selectedImage : UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarView?.backgroundColor = UIColor.clear
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
extension BaseViewController {
    
    func chooseImage(pickImage : Bool = true, item : String?, isCheckNeeded : Bool = false, success : @escaping (Any) -> (), cancel : @escaping () -> ()) {
        switch /item {
        case "Camera" :
            if !Utility.isCameraPermission() {
                self.showAlertConfirmation(title: "Confirmation", desc: "Do You Want To Change Camera Access Permission From Settings", success: {
                    self.openSetting()
                })
                return
            }
        default :
            if !Utility.accessToPhotos() {
                self.showAlertConfirmation(title: "Confirmation", desc: "Do You Want To Change Library Access Permission From Settings", success: {
                    self.openSetting()
                })
                return
            }
        }
        
        CameraManager.sharedInstance.pickerImage(image : pickImage ,type: item  , presentInVc: self, pickedListner: { [unowned self] (img) in
            success(img)
            }, canceledListner: {
                cancel()
        })
    }
    
    func openSetting(){
        UIApplication.shared.open(URL(string:UIApplicationOpenSettingsURLString)!)
        
    }
    
    func showPicker(actionSheet title : String? , subTitle : String? , vc : UIViewController? , senders : [String] , success : @escaping (String,Int) -> ()){
        
        
        let alert : UIAlertController = UIAlertController(title: title, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        for (i,item) in senders.enumerated() {
            
            let action = UIAlertAction(title: item, style: UIAlertActionStyle.default) {
                UIAlertAction in
                success(item,i)
            }
            alert.addAction(action)
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
            UIAlertAction in
        }
        alert.addAction(cancelAction)
        if UIDevice.current.userInterfaceIdiom == .phone {
            vc?.present(alert, animated: true, completion: nil)
        }
    }
}
extension UIViewController {
    //MARK:- alert view with option
    func showAlertConfirmation(title : String , desc : String, success : @escaping () -> ()){
        let refreshAlert = UIAlertController(title: title, message: desc, preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            refreshAlert .dismiss(animated: true, completion: nil)
            success()
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action: UIAlertAction!) in
            refreshAlert .dismiss(animated: true, completion: nil)
        }))
        
        present(refreshAlert, animated: true, completion: nil)
        
        
    }
    
}
extension UIViewController : NVActivityIndicatorViewable {
    
}
