//
//  Control + Extension.swift
//  vk-login-geekbrains
//
//  Created by Aleksey on 16.04.2020.
//  Copyright © 2020 Aleksey Mikhlev. All rights reserved.
//

import UIKit

extension UIControl {
    func tryTapButton(element: UIButton,
                      resultTrying: Bool,
                      elementCount: Int,
                      elementSymbol: String
    ) -> Bool {
        if resultTrying {
            UIView.transition(with: element,
                      duration: 0.25,
                      options: .transitionCrossDissolve,
                      animations: {
                        element.setTitle("\(elementCount) \(elementSymbol) ", for: .normal)
                        element.setTitleColor(.black, for: .normal)

            })
        //elementCount -= 1
            return !resultTrying
        } else {
            UIView.transition(with: element,
                      duration: 0.25,
                      options: .transitionCrossDissolve,
                      animations: {
                        element.setTitle("\(elementSymbol) \(elementCount)", for: .normal)
                        element.setTitleColor(.red, for: .normal)

            })
        //elementCount -= 1
            return !resultTrying
        }
    }
}
