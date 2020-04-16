//
//  ShadowView.swift
//  vk-login-geekbrains
//
//  Created by Aleksey on 06.04.2020.
//  Copyright © 2020 Aleksey Mikhlev. All rights reserved.
//

import UIKit


class ShadowView: UIView {
    func asCircle() {
        self.layer.cornerRadius = self.bounds.height / 2
    }

    func makeShadow() {
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 3
        self.layer.shadowOffset = CGSize.zero
    }
    func animateResize() {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 1
        animation.toValue = 0.9
        animation.stiffness = 100
        animation.mass = 0
        animation.duration = 0
        animation.autoreverses = true

        animation.beginTime = CACurrentMediaTime()
        animation.fillMode = CAMediaTimingFillMode.forwards
        self.layer.add(animation, forKey: nil)
    }
}
