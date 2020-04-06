//
//  OneFriendCollectionViewController.swift
//  vk-login-geekbrains
//
//  Created by Aleksey on 02.04.2020.
//  Copyright © 2020 Aleksey Mikhlev. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class OneFriendCollectionViewController: UICollectionViewController {
    var friendName: String?
    var friendImage: UIImage?
    var friendAge: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: OneFriendCell.self), for: indexPath) as? OneFriendCell else {
        preconditionFailure("Fail")
    }

        cell.friendImageCell.image = friendImage
        // Configure the cell
    
        return cell
    }
}
