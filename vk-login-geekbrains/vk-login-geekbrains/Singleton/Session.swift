//
//  Session.swift
//  vk-login-geekbrains
//
//  Created by Aleksey on 10.05.2020.
//  Copyright © 2020 Aleksey Mikhlev. All rights reserved.
//

import Foundation

class Session {

    private init() {}

    static let instance = Session()
    
    var token: String = ""
    var id: Int = 0
}
