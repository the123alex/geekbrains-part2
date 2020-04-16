//
//  CommentControl.swift
//  vk-login-geekbrains
//
//  Created by Aleksey on 14.04.2020.
//  Copyright © 2020 Aleksey Mikhlev. All rights reserved.
//

import UIKit

class CommentControl: UIControl {
    var iconButton = UIButton()

    var commentCount = 0
    var isCommented = false
    let randomCount = Int.random(in: 1...10)

    override func awakeFromNib() {
        setupSubview()
    }

    private func setupSubview() {
        commentCount = randomCount

        iconButton.setTitle("\(commentCount) \u{270E}", for: .normal)
        iconButton.setTitleColor(.black, for: .normal)
        iconButton.titleLabel?.font = .systemFont(ofSize: 20)

        iconButton.addTarget(
            self,
            action: #selector(changeCount(_:)),
            for: .touchUpInside
        )

        addSubview(iconButton)

        iconButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            iconButton.topAnchor.constraint(equalTo: topAnchor),
            iconButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            iconButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            iconButton.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }

    @objc func changeCount(_ sender: UIButton) {
        if isCommented {
            commentCount -= 1
        } else {
            commentCount += 1
        }
        isCommented = tryTapButton(
            element: iconButton,
            resultTrying: isCommented,
            elementCount: commentCount,
            elementSymbol: "\u{270E}")
    }
}
