//
//  Codable.swift
//  vk-login-geekbrains
//
//  Created by Aleksey on 21.05.2020.
//  Copyright © 2020 Aleksey Mikhlev. All rights reserved.
//

import Foundation
struct ResultUser: Codable {
   let response: ResponseUser
}

struct ResponseUser: Codable {
    let count: Int
    let items: [ItemsUser]
}

struct ItemsUser: Codable {
    let first_name: String
    let last_name: String
    let crop_photo: CropPhoto?
}

struct CropPhoto: Codable {
   let photo: Photo
}

struct Photo: Codable {
    let photo_807: URL?
   // let id: Int
}

struct ResultGroup: Codable {
    let response: ResponseGroup
}

struct ResponseGroup: Codable {
    let count: Int
    let items: [ItemsGroup]
}

struct ItemsGroup: Codable {
    let name: String
}
