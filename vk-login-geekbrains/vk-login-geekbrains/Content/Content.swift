//
//  Content.swift
//  vk-login-geekbrains
//
//  Created by Aleksey on 06.04.2020.
//  Copyright © 2020 Aleksey Mikhlev. All rights reserved.
//

import Foundation

class Content {
    var images: [String: [String]]
    var likes: [String: Int]

    init(images: [String: [String]], likes: [String: Int]) {
        self.images = images
        self.likes = likes
    }
}
