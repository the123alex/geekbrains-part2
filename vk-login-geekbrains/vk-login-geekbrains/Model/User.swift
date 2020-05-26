//
//  User.swift
//  vk-login-geekbrains
//
//  Created by Aleksey on 02.04.2020.
//  Copyright © 2020 Aleksey Mikhlev. All rights reserved.
//

import RealmSwift
import UIKit

class User: Object {
    @objc dynamic var name: String
    var image: UIImage?

    init(name: String) {
        self.name = name
    }

    override required init() {
        self.name = ""
       // fatalError("init() has not been implemented")
    }
    //
//    required init() {
//        super.init()
//    //    fatalError("init() has not been implemented")
//    }
}
