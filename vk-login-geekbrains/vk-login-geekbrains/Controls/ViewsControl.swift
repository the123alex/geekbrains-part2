//
//  CommentControl.swift
//  vk-login-geekbrains
//
//  Created by Aleksey on 14.04.2020.
//  Copyright © 2020 Aleksey Mikhlev. All rights reserved.
//

import UIKit

class ViewsControl: UIControl {
    var iconViewLabel = UILabel()

    var viewsCount = 0
    let randomCount = Int.random(in: 1...10)

    override func layoutSubviews() {
        setupSubview()
    }

    private func setupSubview() {
        viewsCount = randomCount
        iconViewLabel.text = "\(viewsCount) \u{1F441}"

        addSubview(iconViewLabel)

        iconViewLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            iconViewLabel.topAnchor.constraint(equalTo: topAnchor),
            iconViewLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            iconViewLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            iconViewLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
