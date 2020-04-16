//
//  EditImageView.swift
//  vk-login-geekbrains
//
//  Created by Aleksey on 06.04.2020.
//  Copyright © 2020 Aleksey Mikhlev. All rights reserved.
//

import UIKit

class FriendPreviewImage: UIImageView {
    func asCircle() {
        self.layer.cornerRadius = self.bounds.height / 2
    }
}

