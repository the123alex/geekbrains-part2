//
//  SegueAnimator.swift
//  vk-login-geekbrains
//
//  Created by Aleksey on 23.04.2020.
//  Copyright © 2020 Aleksey Mikhlev. All rights reserved.
//

import UIKit

class SegueAnimatorPush: NSObject, UIViewControllerAnimatedTransitioning {
    private let duration = 2.0

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from) else {
            return
        }

        guard let destination = transitionContext.viewController(forKey: .to) else {
            return
        }

        let containerViewFrame = transitionContext.containerView.frame
        let sourceViewTargetFrame = CGRect(
            x: -containerViewFrame.width,
            y: -containerViewFrame.height,
            width: source.view.frame.size.width,
            height: source.view.frame.size.height
        )
        let destinationViewTargetFrame = transitionContext.containerView.frame
        transitionContext.containerView.addSubview(destination.view)

        destination.view.frame = source.view.frame
        destination.view.transform = destination.view.transform.rotated(by: .pi * 1.5)

        destination.view.frame.origin.x = containerViewFrame.size.width
        destination.view.frame.origin.y = 0

        UIView
            .animate(
            withDuration: duration,
            delay: 0,
            options: .curveEaseInOut,
            animations: {

                source.view.frame = sourceViewTargetFrame
                source.view.transform = source.view.transform.rotated(by: .pi * 0.5)

                destination.view.transform = destination.view.transform.rotated(by: .pi * 0.5)

                destination.view.frame = destinationViewTargetFrame

                
        }) { finished in
            transitionContext.completeTransition(finished)
        }
    }



}
