//
//  ContentViewController.swift
//  vk-login-geekbrains
//
//  Created by Aleksey on 20.04.2020.
//  Copyright © 2020 Aleksey Mikhlev. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {
    @IBOutlet var backView: UIView!

    var leftImageView = UIImageView()
    var midImageView = UIImageView()
    var rightImageView = UIImageView()

    var leftIndex = Int()
    var midIndex = Int()
    var rightIndex = Int()
    var contentArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        if contentArray.count != 0 {
            setIndex(content: contentArray)
            addSubviews()
        }

        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handSwipe))
        leftSwipe.direction = .left
        self.midImageView.superview?.addGestureRecognizer(leftSwipe)

        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handSwipe))
        rightSwipe.direction = .right
        self.midImageView.superview?.addGestureRecognizer(rightSwipe)

        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handSwipe))
        downSwipe.direction = .down
        self.midImageView.superview?.addGestureRecognizer(downSwipe)
    }

//add and reload images
    func addSubviews() {
        backView.addSubview(leftImageView)
        backView.addSubview(midImageView)
        backView.addSubview(rightImageView)

        leftImageView.translatesAutoresizingMaskIntoConstraints = false
        midImageView.translatesAutoresizingMaskIntoConstraints = false
        rightImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            midImageView.centerXAnchor.constraint(equalTo: backView.centerXAnchor),
            midImageView.centerYAnchor.constraint(equalTo: backView.centerYAnchor),
            midImageView.widthAnchor.constraint(equalToConstant: 275),
            midImageView.heightAnchor.constraint(equalToConstant: 300)
        ])

        NSLayoutConstraint.activate([
            leftImageView.trailingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 30),
            leftImageView.centerYAnchor.constraint(equalTo: backView.centerYAnchor),
            leftImageView.widthAnchor.constraint(equalToConstant: 200),
            leftImageView.heightAnchor.constraint(equalToConstant: 200)
        ])

        NSLayoutConstraint.activate([
            rightImageView.leadingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -30),
            rightImageView.centerYAnchor.constraint(equalTo: backView.centerYAnchor),
            rightImageView.widthAnchor.constraint(equalToConstant: 200),
            rightImageView.heightAnchor.constraint(equalToConstant: 200)
        ])

        leftImageView.image = UIImage(named: self.contentArray[self.leftIndex])
        midImageView.image = UIImage(named: self.contentArray[self.midIndex])
        rightImageView.image = UIImage(named: self.contentArray[self.rightIndex])
        leftImageView.alpha = 0.5
        rightImageView.alpha = 0.5
    }
    
//set index for choosed image
    func setIndex(content: [String]) {
        if content.count > 2 {
            if midIndex == content.count - 1 {
                leftIndex = midIndex - 1
                rightIndex = 0
            } else {
                if midIndex == 0 {
                    leftIndex = content.count - 1
                    rightIndex = midIndex + 1
                } else {
                    leftIndex = midIndex - 1
                    rightIndex = midIndex + 1
                }
            }
        } else if content.count == 2 {
            leftIndex = midIndex != 0 ? 0 : 1
            rightIndex = midIndex != 0 ? 0 : 1
        } else {
            leftIndex = midIndex
            rightIndex = midIndex
        }
    }

//check swipe
    @objc func handSwipe(gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case .left:
            UIView.animateKeyframes(
                withDuration: 0.8,
                delay: 0,
                options: .beginFromCurrentState,
                animations: {
                    UIView.addKeyframe(
                        withRelativeStartTime: 0,
                        relativeDuration: 1,
                        animations: {
                            self.midImageView.frame = self.midImageView.frame.offsetBy(
                                dx: -100,
                                dy: 0
                            )
                            self.leftImageView.frame = self.leftImageView.frame.offsetBy(
                                dx: -100,
                                dy: 0
                            )

                            self.rightImageView.frame = self.rightImageView.frame.offsetBy(
                                dx: -100,
                                dy: 0
                            )
                            self.midImageView.transform = CGAffineTransform(
                                scaleX: 0.8,
                                y: 0.8
                            )
                            self.midImageView.alpha = 0.65
                    })
            }, completion:{ _ in
                UIView.animate(
                    withDuration: 0.5,
                    delay: 0,
                    options: .curveEaseInOut,
                    animations: {
                        self.midImageView.frame = self.midImageView.frame.offsetBy(
                            dx: 100,
                            dy: 0
                        )
                        self.leftImageView.frame = self.leftImageView.frame.offsetBy(
                            dx: 100,
                            dy: 0
                        )
                        self.rightImageView.frame = self.rightImageView.frame.offsetBy(
                            dx: 100,
                            dy: 0
                        )
                        self.midImageView.transform = .identity
                        self.midImageView.alpha = 1
                        self.addSubviews()
                })
            })
                if self.midIndex == self.contentArray.count - 1 {
                    self.midIndex = 0
                    self.setIndex(content: self.contentArray)
                } else {
                    self.midIndex += 1
                    self.setIndex(content: self.contentArray)
                }

        case .right:
            UIView.animateKeyframes(
                withDuration: 0.8,
                delay: 0,
                options: .beginFromCurrentState,
                animations: {
                    UIView.addKeyframe(
                        withRelativeStartTime: 0,
                        relativeDuration: 1,
                        animations: {
                            self.midImageView.frame = self.midImageView.frame.offsetBy(
                                dx: 100,
                                dy: 0
                            )
                            self.leftImageView.frame = self.leftImageView.frame.offsetBy(
                                dx: 100,
                                dy: 0
                            )
                            self.rightImageView.frame = self.rightImageView.frame.offsetBy(
                                dx: 100,
                                dy: 0
                            )
                            self.midImageView.transform = CGAffineTransform(
                                scaleX: 0.8,
                                y: 0.8
                            )
                            self.midImageView.alpha = 0.65
                    })
            }, completion:{ _ in
                UIView.animate(
                    withDuration: 0.5,
                    delay: 0,
                    options: .curveEaseInOut,
                    animations: {
                        self.midImageView.frame = self.midImageView.frame.offsetBy(
                            dx: -100,
                            dy: 0
                        )
                        self.leftImageView.frame = self.leftImageView.frame.offsetBy(
                            dx: -100,
                            dy: 0
                        )
                        self.rightImageView.frame = self.rightImageView.frame.offsetBy(
                            dx: -100,
                            dy: 0
                        )
                        self.midImageView.transform = .identity
                        self.midImageView.alpha = 1
                        self.addSubviews()
                })
            })
            if midIndex == 0 {
                midIndex = contentArray.count - 1
                setIndex(content: contentArray)
            } else {
                midIndex -= 1
                setIndex(content: contentArray)
            }
        case .down:
            self.backToCollection(self)
            //прозрачность приходится менять, иначе при возврате остаётся тень левой картинки
            self.leftImageView.alpha = 0
        default:
            return
        }
    }

    @IBAction func backToCollection(_ sender: Any) {
        performSegue(withIdentifier: "imageChoosedUnwind", sender: self)
    }
}

