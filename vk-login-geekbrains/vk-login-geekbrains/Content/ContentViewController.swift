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
    var firstImageView = UIImageView()
    var secondImageView = UIImageView()
    var thirdImageView = UIImageView()

    override func viewDidLoad() {
        addSubview()
        print(contentArray)
    }


    func addSubview() {
        backView.addSubview(firstImageView)
               backView.addSubview(secondImageView)
               backView.addSubview(thirdImageView)

               firstImageView.translatesAutoresizingMaskIntoConstraints = false
               secondImageView.translatesAutoresizingMaskIntoConstraints = false
               thirdImageView.translatesAutoresizingMaskIntoConstraints = false

               NSLayoutConstraint.activate([
                   firstImageView.centerXAnchor.constraint(equalTo: backView.centerXAnchor),
                   firstImageView.centerYAnchor.constraint(equalTo: backView.centerYAnchor),
                   firstImageView.widthAnchor.constraint(equalToConstant: 200),
                   firstImageView.heightAnchor.constraint(equalToConstant: 200)
               ])

               NSLayoutConstraint.activate([
                   secondImageView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: -150),
                   secondImageView.centerYAnchor.constraint(equalTo: backView.centerYAnchor),
                   secondImageView.widthAnchor.constraint(equalToConstant: 200),
                   secondImageView.heightAnchor.constraint(equalToConstant: 200)
               ])
               NSLayoutConstraint.activate([
                   thirdImageView.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: 150),
                   thirdImageView.centerYAnchor.constraint(equalTo: backView.centerYAnchor),
                   thirdImageView.widthAnchor.constraint(equalToConstant: 200),
                   thirdImageView.heightAnchor.constraint(equalToConstant: 200)
               ])
               firstImageView.image = UIImage(named: "max")
               secondImageView.image = UIImage(named: "boris2")
               thirdImageView.image = UIImage(named: "max2")


        }
}
