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
    @objc dynamic var id: Int = 0

    var crop_photo: CropPhoto?

    init(first_name: String, last_name: String, crop_photo: CropPhoto) {
        self.first_name = first_name
        self.last_name = last_name
        self.crop_photo = crop_photo
    }

    override required init() {
      //  fatalError("init() has not been implemented")
    }
    override static func primaryKey() -> String? {
        return "id"
    }
}

class CropPhoto: Object, Codable {
  var photo: Photo?
}

class Photo: Object, Codable {
    var photo_807: URL?
    @objc dynamic var photoName: String {
        let result = String("\(photo_807)")
        return result
    }
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
    @objc dynamic var id: Int = 0


    override static func primaryKey() -> String? {
        return "id"
    }
}
