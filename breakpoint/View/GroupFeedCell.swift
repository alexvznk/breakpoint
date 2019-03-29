//
//  GroupFeedCell.swift
//  breakpoint
//
//  Created by Alex on 3/27/19.
//  Copyright © 2019 Alex Vozniuk. All rights reserved.
//

import UIKit

class GroupFeedCell: UITableViewCell {
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var contentLbl: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(profileImage: UIImage, email: String, content: String) {
        self.profileImage.image = profileImage
        self.emailLbl.text = email
        self.contentLbl.text = content
    }

}
