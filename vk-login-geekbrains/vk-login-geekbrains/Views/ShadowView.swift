//
//  ShadowView.swift
//  vk-login-geekbrains
//
//  Created by Aleksey on 06.04.2020.
//  Copyright © 2020 Aleksey Mikhlev. All rights reserved.
//

import UIKit

class ShadowView: UIView {
    func asCircle(){
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.masksToBounds = true
    }
}
