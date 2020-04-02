//
//  AllFriendsTableViewController.swift
//  vk-login-geekbrains
//
//  Created by Aleksey on 31.03.2020.
//  Copyright © 2020 Aleksey Mikhlev. All rights reserved.
//

import UIKit

var someFriends = [
    User(name: "Boris", age: 22, image: UIImage(named: "default")!),
    User(name: "Anna", age: 44, image: UIImage(named: "default")!),
    User(name: "Ivan", age: 32, image: UIImage(named: "default")!)
    ]


class AllFriendsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return someFriends.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath)

        cell.textLabel?.text = someFriends[indexPath.row].name

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
