//
//  Firebase.swift
//  vk-login-geekbrains
//
//  Created by Aleksey on 08.06.2020.
//  Copyright © 2020 Aleksey Mikhlev. All rights reserved.
//

import Foundation
import Firebase

class FirebaseUser {
    // 1
    let id: Int
    var groups: [String] = []
    let ref: DatabaseReference?

    init(id: Int) {
        // 2
        self.ref = nil
        self.id = id
    }

    init?(snapshot: DataSnapshot) {
        // 3
        guard
            let value = snapshot.value as? [String: Any],
            let id = value["id"] as? Int,
            let groups = value["groups"] as? [String]? else {
                return nil
        }

        self.ref = snapshot.ref
        self.id = id
    }

    func toAnyObject() -> [String: Any] {
        // 4
        return [
            "id": id,
            "groups": groups
        ]
    }
}
