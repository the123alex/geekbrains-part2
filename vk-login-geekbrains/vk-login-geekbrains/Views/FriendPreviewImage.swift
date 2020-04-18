//
//  EditImageView.swift
//  vk-login-geekbrains
//
//  Created by Aleksey on 06.04.2020.
//  Copyright © 2020 Aleksey Mikhlev. All rights reserved.
//

import UIKit

class FriendPreviewImage: UIImageView {
    func asCircle() {
        self.layer.cornerRadius = self.bounds.height / 2
    }
    
    func animateResize() {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 1
        animation.toValue = 0.9
        animation.stiffness = 100
        animation.mass = 1
        animation.duration = 0
        animation.autoreverses = true

        animation.beginTime = CACurrentMediaTime()
        animation.fillMode = CAMediaTimingFillMode.forwards
        self.layer.add(animation, forKey: nil)
    }
}

