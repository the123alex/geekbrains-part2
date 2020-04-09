//
//  LikeControl.swift
//  vk-login-geekbrains
//
//  Created by Aleksey on 06.04.2020.
//  Copyright © 2020 Aleksey Mikhlev. All rights reserved.
//

import UIKit

class LikeControl: UIControl {
    var iconButton = UIButton()

    var likesCount = 0
    var isLiked = false
    var randomLikes = Int.random(in: 1...10)

    override func layoutSubviews() {
        setupSubview()
    }

    private func setupSubview() {
        likesCount = randomLikes
        
        iconButton.setTitle("\(likesCount) \u{2665}", for: .normal)
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
        if isLiked {
            likesCount -= 1
            iconButton.setTitle("\(likesCount) \u{2665}", for: .normal)
            iconButton.setTitleColor(.black, for: .normal)
            isLiked.toggle()
        } else {
            likesCount += 1
            iconButton.setTitle("\(likesCount) \u{2665}", for: .normal)
            iconButton.setTitleColor(.red, for: .normal)
            isLiked.toggle()
        }
    }
}
