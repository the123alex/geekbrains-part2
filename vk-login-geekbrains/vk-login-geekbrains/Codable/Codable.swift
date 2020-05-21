//
//  Codable.swift
//  vk-login-geekbrains
//
//  Created by Aleksey on 21.05.2020.
//  Copyright © 2020 Aleksey Mikhlev. All rights reserved.
//

import Foundation
struct Users: Codable {
   let response: Response
}

struct Response: Codable {
    let count: Int
    let items: [Items]
}

struct Items: Codable {
    let first_name: String
    let last_name: String
}
