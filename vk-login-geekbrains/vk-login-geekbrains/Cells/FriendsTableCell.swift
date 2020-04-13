//
//  FriendsTableCell.swift
//  vk-login-geekbrains
//
//  Created by Aleksey on 02.04.2020.
//  Copyright © 2020 Aleksey Mikhlev. All rights reserved.
//

import UIKit

class FriendsTableCell: UITableViewCell {
    @IBOutlet weak var friendNameCell: UILabel!
    
    @IBOutlet weak var friendImageCell: FriendPreviewImage!

    @IBOutlet weak var viewForShadow: ShadowView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
