//
//  LikeControl.swift
//  vk-login-geekbrains
//
//  Created by Aleksey on 06.04.2020.
//  Copyright © 2020 Aleksey Mikhlev. All rights reserved.
//

import UIKit

class LikeControl: UIControl {
    var likesCount = 0
    var liked = false
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupSubview()
    }
    
    private func setupSubview() {

        let likes = UILabel()
        likes.bounds = self.frame
        likes.text = "\u{2661}" + String(likesCount)
        likes.textAlignment = .center
        likes.textColor = .black
        addSubview(likes)
        likes.center = CGPoint(x: self.frame.size.width  / 2,
                               y: self.frame.size.height / 2)

        self.backgroundColor = .yellow
    }

    func test() {
        print("test func")
        likesCount = 1
    }
}
