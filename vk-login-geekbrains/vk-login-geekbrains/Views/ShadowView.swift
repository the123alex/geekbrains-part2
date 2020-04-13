//
//  ShadowView.swift
//  vk-login-geekbrains
//
//  Created by Aleksey on 06.04.2020.
//  Copyright © 2020 Aleksey Mikhlev. All rights reserved.
//

import UIKit


@IBDesignable class ShadowView: UIView {

    @IBInspectable var radius: CGFloat = 10 {
        didSet {
            self.asCircle()
        }
    }

    @IBInspectable var shadowColor: UIColor = UIColor.black {
        didSet {
            self.makeShadow()
        }
    }

    @IBInspectable var shadowRadius: CGFloat = 1 {
        didSet {
            self.makeShadow()
        }
    }

    @IBInspectable var shadowOpacity: Float = 1 {
    didSet {
        self.makeShadow()
    }
}
    func asCircle() {
      //  self.layer.cornerRadius = self.bounds.height / 2
        self.layer.cornerRadius = radius

    }

    func makeShadow() {
//        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOffset = CGSize.zero
    }
}
