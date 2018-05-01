//
//  UserListTableViewCell.swift
//  Test
//
//  Created by MACMINI_CBL on 5/1/18.
//  Copyright © 2018 Monika. All rights reserved.
//

import UIKit
import IBAnimatable
import SDWebImage

class UserListTableViewCell: UITableViewCell {

    @IBOutlet var lblName: UILabel!
    @IBOutlet var imgUser: AnimatableImageView!
    
    
    func configureCell(model : UserList) {
        lblName.text = /model.first_name + " " + /model.last_name
        imgUser.sd_setImage(with: URL(string : /model.avatar), completed: nil)
    }

}
