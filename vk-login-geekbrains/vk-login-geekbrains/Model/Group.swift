//
//  Group.swift
//  vk-login-geekbrains
//
//  Created by Aleksey on 02.04.2020.
//  Copyright © 2020 Aleksey Mikhlev. All rights reserved.
//

import RealmSwift
import UIKit

class Group: Object {
    @objc dynamic var title: String
    var image: UIImage

    init(title: String, image: UIImage) {
        self.title = title
        self.image = image
    }

    override required init() {
        self.title = ""
        self.image = UIImage(named: "default")!
        //fatalError("init() has not been implemented")
    }
}
