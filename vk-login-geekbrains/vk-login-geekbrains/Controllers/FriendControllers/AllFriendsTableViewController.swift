//
//  AllFriendsTableViewController.swift
//  vk-login-geekbrains
//
//  Created by Aleksey on 31.03.2020.
//  Copyright © 2020 Aleksey Mikhlev. All rights reserved.
//

import UIKit

class AllFriendsTableViewController: UITableViewController {
    var someFriends = [
        User(name: "Boris", age: 22, image: UIImage(named: "default")!),
        User(name: "Anna", age: 44, image: UIImage(named: "default")!),
        User(name: "Ivan", age: 32, image: UIImage(named: "default")!)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return someFriends.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FriendsTableCell.self), for: indexPath) as? FriendsTableCell else {
            preconditionFailure("Fail")
        }
        cell.friendNameCell?.text = someFriends[indexPath.row].name

        if UIImage(named: someFriends[indexPath.row].name) != nil {
            cell.friendImageCell.image = UIImage(named: someFriends[indexPath.row].name)
        } else {
            cell.friendImageCell.image = someFriends[indexPath.row].image
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier! == "Friend segue",
            let indexPath = tableView.indexPathForSelectedRow {

                let friend = someFriends[indexPath.row]
                let destinationViewController = segue.destination as? OneFriendCollectionViewController
                destinationViewController?.friendName = friend.name
                destinationViewController?.friendAge = "Age - " + String(friend.age)

                if UIImage(named: friend.name) != nil {
                    destinationViewController?.friendImage = UIImage(named: friend.name)
                } else {
                    destinationViewController?.friendImage = friend.image
                }
        }
    }
}
