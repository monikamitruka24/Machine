//
//  UserDetailViewController.swift
//  Test
//
//  Created by MACMINI_CBL on 5/1/18.
//  Copyright © 2018 Monika. All rights reserved.
//

import UIKit
import SDWebImage
import IBAnimatable

protocol UserDetailProtocol {
    func sendImageUrl(index : Int,url : String)
}

class UserDetailViewController: BaseViewController {
    
     //MARK:- outlet
    @IBOutlet var imgUser: AnimatableImageView!
    @IBOutlet weak var lblName: UILabel!
    
     //MARK:- variable
    var userObj : UserList?
    var index = 0
    var delegate : UserDetailProtocol?
    
    @IBAction func btnActionBack(_ sender: Any) {
        popVC()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        lblName.text = /userObj?.first_name + " " + /userObj?.last_name
        imgUser.sd_setImage(with: URL(string : /userObj?.avatar), completed: nil)
        imgUser.addTapGesture { (gesture) in
            self.actionProfilePic()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //MARK:- FUNCTION
    func actionProfilePic() {
        self.showPicker(actionSheet: "Choose Image", subTitle: "", vc: self, senders: ["Camera", "Gallery"], success: { (item, i) in
            self.chooseImage(item: item, success: { (img) in
                guard let image = img as? UIImage else { return }
                self.imgUser.contentMode = UIViewContentMode.scaleAspectFill
                self.imgUser.image =  image
                self.selectedImage = image
                self.uploadImage()
                
            }, cancel: {
                //
            })
        })
    }
    
    
    func  uploadImage() {
        var arrImg : [UIImage] = []
        if let img = self.selectedImage {
            arrImg = [img]
        }else {
            arrImg = []
        }
        
        APIManager.shared.request(withImages:  ImageEndPoint.editImage(contentType : "0",maxSize: "420"), images: arrImg, completion: { [unowned self](response) in
            switch response{
            case .success(let dataResponse):
                guard let str = dataResponse as? String else { return }
                self.delegate?.sendImageUrl(index: self.index, url: str)
                self.popVC()
            case .failure(let str):
                Alerts.shared.show(alert: .oops, message: str as? String ?? "", type: .error)
            }
        })
    }
    
    
    
}
