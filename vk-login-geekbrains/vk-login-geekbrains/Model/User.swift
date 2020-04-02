//
//  User.swift
//  vk-login-geekbrains
//
//  Created by Aleksey on 02.04.2020.
//  Copyright © 2020 Aleksey Mikhlev. All rights reserved.
//

import UIKit

class User {
    let name: String
    let age: UInt
    let image: UIImage

    init(name: String, age: UInt, image: UIImage) {
        self.name = name
        self.age = age
        self.image = image
    }
}
