//
//  User.swift
//  vk-login-geekbrains
//
//  Created by Aleksey on 02.04.2020.
//  Copyright © 2020 Aleksey Mikhlev. All rights reserved.
//

import UIKit

class User {
    var name: String
    var id: Int = 0

    var image: UIImage?

    init(name: String) {
        self.name = name
    }
}
