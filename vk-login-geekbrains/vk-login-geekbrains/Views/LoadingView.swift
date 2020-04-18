//
//  LoadingView.swift
//  vk-login-geekbrains
//
//  Created by Aleksey on 17.04.2020.
//  Copyright © 2020 Aleksey Mikhlev. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    var firstDot = UIView()
    var secondDot = UIView()
    var thirdDot = UIView()

    let dotStack: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.spacing = 10

        return stackView
    }()

    override func awakeFromNib() {
        createView()
    }

    private func createView() {
        let usedDots = [firstDot, secondDot, thirdDot]
        self.addSubview(dotStack)

        createDots(usedDots)
        createAnimation(dots: usedDots)

        dotStack.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            dotStack.topAnchor.constraint(equalTo: topAnchor),
            dotStack.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    private func createDots(_ dots: [UIView]) {
        for element in dots {
            element.backgroundColor = .black
            element.alpha = 0
            NSLayoutConstraint.activate([
                element.heightAnchor.constraint(equalToConstant: 30),
                element.widthAnchor.constraint(equalToConstant: 30),
            ])
            element.layer.cornerRadius = 15
            dotStack.addArrangedSubview(element)
        }
    }

    private func createAnimation(dots: [UIView]) {
        for number in 0..<dots.count {
            UIView.animate(
                withDuration: 3,
                delay: TimeInterval(number),
                options: [.repeat, .autoreverse],
                animations:
                {
                dots[number].alpha = 1
            })
        }
    }
}
