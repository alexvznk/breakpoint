//
//  UserCell.swift
//  breakpoint
//
//  Created by Alex on 3/26/19.
//  Copyright © 2019 Alex Vozniuk. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var checkImage: UIImageView!
    
    var showing = false
    
    func configureCell(profileImage image: UIImage, email: String, isSelected: Bool) {
        self.profileImage.image = image
        self.emailLbl.text = email
        if isSelected {
                self.checkImage.isHidden = false
            } else {
                self.checkImage.isHidden = true
            }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            if showing == false {
                self.checkImage.isHidden = false
                showing = true
            } else {
                self.checkImage.isHidden = true
                showing = false
            }
    }
}
    
}
