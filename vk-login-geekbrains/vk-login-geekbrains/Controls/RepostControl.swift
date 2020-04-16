//
//  CommentControl.swift
//  vk-login-geekbrains
//
//  Created by Aleksey on 14.04.2020.
//  Copyright © 2020 Aleksey Mikhlev. All rights reserved.
//

import UIKit

class RepostControl: UIControl {
    var iconButton = UIButton()

    var repostCount = 0
    var isReposted = false
    let randomCount = Int.random(in: 1...10)

    override func awakeFromNib() {
        setupSubview()
    }

    private func setupSubview() {
        repostCount = randomCount

        iconButton.setTitle("\(repostCount) \u{27A5}", for: .normal)
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
        if isReposted {
            repostCount -= 1
        } else {
            repostCount += 1
        }
        isReposted = tryTapButton(
            element: iconButton,
            resultTrying: isReposted,
            elementCount: repostCount,
            elementSymbol: "\u{27A5}")
    }
}
