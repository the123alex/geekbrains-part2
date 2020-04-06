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
    var friendImage: UIImage?
    var friendContent: Content?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return friendContent?.titles.count ?? 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: OneFriendCell.self), for: indexPath) as? OneFriendCell else {
        preconditionFailure("Fail")
    }

        cell.friendImageCell.image = UIImage(named: (friendContent?.titles[indexPath.section])!)
        // Configure the cell
    
        return cell
    }
}
