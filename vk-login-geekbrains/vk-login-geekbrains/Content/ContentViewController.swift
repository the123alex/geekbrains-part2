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

    var contentArray = [String]()
    var leftImageView = UIImageView()
    var midImageView = UIImageView()
    var rightImageView = UIImageView()

    var leftIndex = Int()
    var midIndex = Int()
    var rightIndex = Int()

    override func viewDidLoad() {
        if contentArray.count != 0 {
            setIndex(content: contentArray)
            addSubviews()
        }

//        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
//        midImageView.superview!.addGestureRecognizer(recognizer)
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handSwipe))
        leftSwipe.direction = .left
        self.midImageView.superview?.addGestureRecognizer(leftSwipe)

        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handSwipe))
        rightSwipe.direction = .right
        self.midImageView.superview?.addGestureRecognizer(rightSwipe)
    }

    @objc func handSwipe(gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case .left:
            if midIndex == contentArray.count - 1 {
                midIndex = 0
                setIndex(content: contentArray)
              //  view.reloadInputViews()
                //view.reloadInputViews()
                addSubviews()
            } else {
                midIndex += 1
                setIndex(content: contentArray)
                addSubviews()
                //view.reloadInputViews()
            }
        case .right:
            if midIndex == 0 {
                midIndex = contentArray.count - 1
                setIndex(content: contentArray)

                addSubviews()
                //view.reloadInputViews()
            } else {
                midIndex -= 1
                setIndex(content: contentArray)
                addSubviews()
            //view.reloadInputViews()

            }

        default:
            return
        }
    }
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
            midImageView.widthAnchor.constraint(equalToConstant: 200),
            midImageView.heightAnchor.constraint(equalToConstant: 200)
        ])

        NSLayoutConstraint.activate([
            leftImageView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: -150),
            leftImageView.centerYAnchor.constraint(equalTo: backView.centerYAnchor),
            leftImageView.widthAnchor.constraint(equalToConstant: 200),
            leftImageView.heightAnchor.constraint(equalToConstant: 200)
        ])

        NSLayoutConstraint.activate([
            rightImageView.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: 150),
            rightImageView.centerYAnchor.constraint(equalTo: backView.centerYAnchor),
            rightImageView.widthAnchor.constraint(equalToConstant: 200),
            rightImageView.heightAnchor.constraint(equalToConstant: 200)
        ])

        leftImageView.image = UIImage(named: contentArray[leftIndex])
        midImageView.image = UIImage(named: contentArray[midIndex])
        rightImageView.image = UIImage(named: contentArray[rightIndex])
    }
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

    var interactiveAnimator: UIViewPropertyAnimator!

//    @objc func onPan(_ recognizer: UIPanGestureRecognizer) {
//
//        switch recognizer.state {
//        case .began:
//            interactiveAnimator = UIViewPropertyAnimator(
//                duration: 0,
//                curve: .easeInOut,
//                animations: {
//                    self.midImageView.frame = self.midImageView.frame.offsetBy(
//                        dx: 10,
//                        dy: 100
//                    )
//                    self.leftImageView.frame = self.leftImageView.frame.offsetBy(
//                        dx: 10,
//                        dy: 0
//                    )
//                    self.rightImageView.frame = self.rightImageView.frame.offsetBy(
//                        dx: 10,
//                        dy: 0
//                    )
//            })
//          //  interactiveAnimator.pauseAnimation()
//        case .changed:
//            let translation = recognizer.translation(in: self.view)
//            print(translation.x)
//            interactiveAnimator.fractionComplete = translation.x / 100
//        case .ended:
//            interactiveAnimator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
//        default: return
//        }
//    }

}

