//
//  UserList.swift
//  Test
//
//  Created by MACMINI_CBL on 5/1/18.
//  Copyright © 2018 Monika. All rights reserved.
//

import UIKit
import SwiftyJSON

class UserList: NSObject {
    
    var id : String?
    var first_name : String?
    var last_name : String?
    var avatar : String?
    
    required init(attributes: OptionalJSON) {
        super.init()
        id = .id => attributes
        first_name = .first_name => attributes
        last_name = .last_name => attributes
        avatar = .avatar => attributes
        
    }
    
    override init() {
        super.init()
    }
    
    
    static func changeDictToModelArray (jsoon1 : [JSON] ) -> [UserList] {
        var tempArr : [UserList] = []
        for item in jsoon1 {
            let msgObj = UserList(attributes: item.dictionaryValue)
            tempArr.append(msgObj)
        }
        return (tempArr)
    }
}

class UserListData : NSObject {
    
    var page : String?
    var per_page : String?
    var total : String?
    var total_pages : String?
    var arrUserList : [UserList] = []
    
    required init(attributes: OptionalJSON) {
        super.init()
        page = .page => attributes
        total = .total => attributes
        total_pages = .total_pages => attributes
        per_page = .per_page => attributes
        arrUserList = UserList.changeDictToModelArray(jsoon1: ((.data =| attributes) ?? []))
    }
    
    override init() {
        super.init()
    }
    
    
   
}

