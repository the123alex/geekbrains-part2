//
//  EditImageView.swift
//  vk-login-geekbrains
//
//  Created by Aleksey on 06.04.2020.
//  Copyright © 2020 Aleksey Mikhlev. All rights reserved.
//

import UIKit

class FriendPreviewImage: UIImageView {

    @IBInspectable var radius: CGFloat = 10 {
        didSet {
            self.asCircle()
        }
    }

    func asCircle() {
        self.layer.cornerRadius = radius
    }
}

