//
//  Alerts.swift
//  cozo
//z
//  Created by Sierra 4 on 05/05/17.
//  Copyright © 2017 monika. All rights reserved.
//

import UIKit
import ISMessages
import EZSwiftExtensions

typealias AlertBlock = (_ success: AlertTag) -> ()

enum AlertTag {
    case done
    case yes
    case no
}

class Alerts: NSObject {
    
    static let shared = Alerts()
    
    func show(alert title : Alert , message : String? , type : ISAlertType){
        
        ISMessages.hideAlert(animated: true)
        
        ISMessages.showCardAlert(withTitle: title.rawValue , message: /message , duration: 0.5 , hideOnSwipe: true , hideOnTap: true , alertType: type , alertPosition: .bottom , didHide: nil)
        ez.runThisAfterDelay(seconds: 4.0) {
            ISMessages.hideAlert(animated: true)
        }
        
    }
    
}



    

