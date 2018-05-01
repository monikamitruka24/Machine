//
//  SignupViewController.swift
//  Test
//
//  Created by Monika on 01/05/18.
//  Copyright © 2018 Monika. All rights reserved.
//

import UIKit
import ACFloatingTextfield_Swift

class SignupViewController: UIViewController {    
    //MARK:- OUTLETS
    @IBOutlet weak var txtPassword: ACFloatingTextfield!
    @IBOutlet weak var txtEmail: ACFloatingTextfield!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
   
}
extension SignupViewController {
    
    @IBAction func btnActionLogin(_ sender: Any) {
        guard let vc = R.storyboard.main.loginViewController() else { return }
        self.pushVC(vc)
    }
    
    @IBAction func btnActionShow(_ sender: Any) {
        txtPassword.isSecureTextEntry = !txtPassword.isSecureTextEntry
    }
    
    @IBAction func btnActionsignup(_ sender: Any) {
        self.view.endEditing(true)
        if "".login(email: txtEmail.text,password : txtPassword.text) {
            APIManager.shared.request(with: HomeEndpoint.register(email: txtEmail.text, password: txtPassword.text)) { [unowned self](response) in
                switch response{
                case .success(let dataResponse):
                    let str = dataResponse as? String
                    if /str != "" {
                         Alerts.shared.show(alert: .alert, message: "Account created successfully", type: .info)
                        guard let vc = R.storyboard.main.userListViewController() else { return }
                        self.pushVC(vc)
                    }
              
                case .failure(let str):
                    Alerts.shared.show(alert: .oops, message: str as? String ?? "", type: .error)
                }
            }
        }
    }
}
