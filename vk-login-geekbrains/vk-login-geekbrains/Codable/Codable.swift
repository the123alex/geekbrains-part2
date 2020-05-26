//
//  Codable.swift
//  vk-login-geekbrains
//
//  Created by Aleksey on 21.05.2020.
//  Copyright © 2020 Aleksey Mikhlev. All rights reserved.
//

import Foundation
import RealmSwift

struct ResultUser: Codable {
   let response: ResponseUser
}

struct ResponseUser: Codable {
    let count: Int
    let items: [ItemsUser]
}

class ItemsUser: Object, Codable {
    @objc dynamic var first_name: String = ""
    @objc dynamic var last_name: String = ""
    var crop_photo: CropPhoto?

    init(first_name: String, last_name: String) {
        self.first_name = first_name
        self.last_name = last_name
      //  self.crop_photo = crop_photo
    }

    override required init() {
      //  fatalError("init() has not been implemented")
    }
}

class CropPhoto: Object, Codable {
  // @objc dynamic var photo: Photo
}

class Photo: Object, Codable {
    var photo_807: URL?
}

struct ResultGroup: Codable {
    let response: ResponseGroup
}

struct ResponseGroup: Codable {
    let count: Int
    let items: [ItemsGroup]
}

class ItemsGroup: Object, Codable {
    @objc dynamic var name: String = ""
}
