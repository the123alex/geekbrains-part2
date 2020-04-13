//
//  AllFriendsTableViewController.swift
//  vk-login-geekbrains
//
//  Created by Aleksey on 31.03.2020.
//  Copyright © 2020 Aleksey Mikhlev. All rights reserved.
//

import UIKit

class AllFriendsTableViewController: UITableViewController {
    @IBOutlet weak var friendSearchBar: UISearchBar!

    var someFriends = [
        User(name: "Boris", age: 22, image: UIImage(named: "default")!),
        User(name: "Anna", age: 44, image: UIImage(named: "default")!),
        User(name: "Ivan", age: 32, image: UIImage(named: "default")!),
        User(name: "Bob", age: 32, image: UIImage(named: "default")!),
        User(name: "Carl", age: 32, image: UIImage(named: "default")!),
        User(name: "Margaret", age: 32, image: UIImage(named: "default")!),
        User(name: "Cris", age: 32, image: UIImage(named: "default")!),
        User(name: "Zorro", age: 32, image: UIImage(named: "default")!),
        User(name: "Luke", age: 32, image: UIImage(named: "default")!),
        User(name: "Steven", age: 32, image: UIImage(named: "default")!),
        User(name: "Steven", age: 32, image: UIImage(named: "default")!),
        User(name: "Max", age: 32, image: UIImage(named: "default")!),
        User(name: "Mary", age: 32, image: UIImage(named: "default")!)
    ]

    var content: Content = Content(images: [:], likes: [:])

    var friendsNames: [String] = []
    var dictFriends: [String: [User]] = [:]

    var friendSearch = [String]()
    var searchFriendDict: [String: [User]] = [:]

    var searching = false
    override func viewDidLoad() {
        super.viewDidLoad()
        content.images.updateValue(["max", "max2", "max3" ], forKey: "Max")
        content.images.updateValue(["boris1", "boris2"], forKey: "Boris")
        
        content.likes.updateValue(10, forKey: "max")
        content.likes.updateValue(100, forKey: "max2")
        content.likes.updateValue(50, forKey: "max3")
        makeFriendsList()
        setUpSearchBar()
        //self.searchBar(friendSearchBar, textDidChange: "")
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        if searching {
            return searchFriendDict.keys.count
        } else {
            return dictFriends.keys.count
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchFriendDict[friendSearch[section]]!.count
            } else {
            return dictFriends[friendsNames[section]]!.count
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if searching {
            return friendSearch[section].first?.uppercased()
        } else {
        return friendsNames[section].first?.uppercased()
        }
    }

    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
           return Array(Set(friendsNames.compactMap{ $0.first?.uppercased() } )).sorted()
       }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FriendsTableCell.self), for: indexPath) as? FriendsTableCell else {
            preconditionFailure("Fail")
        }

        if searching {
            guard let friends = searchFriendDict[friendSearch[indexPath.section]]?[indexPath.row] else
                {
                preconditionFailure("Fail")
                }
                cell.friendNameCell?.text = friends.name
                cell.friendImageCell?.image = friends.image
                cell.friendImageCell?.asCircle()
            //  cell.viewForShadow?.asCircle()
                cell.viewForShadow?.makeShadow()

                if UIImage(named: friends.name) != nil {
                cell.friendImageCell.image = UIImage(named: friends.name)
                }

        } else {

        guard let friends = dictFriends[friendsNames[indexPath.section]]?[indexPath.row] else {
            preconditionFailure("Fail")
            }
        cell.friendNameCell?.text = friends.name
        cell.friendImageCell?.image = friends.image
        cell.friendImageCell?.asCircle()
      //  cell.viewForShadow?.asCircle()
        cell.viewForShadow?.makeShadow()

        if UIImage(named: friends.name) != nil {
            cell.friendImageCell.image = UIImage(named: friends.name)
            }
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier! == "Friend segue",
            let indexPath = tableView.indexPathForSelectedRow {

            guard let friend = dictFriends[friendsNames[indexPath.section]]?[indexPath.row] else {
                preconditionFailure("Fail")
            }
            let destinationViewController = segue.destination as? OneFriendCollectionViewController
            destinationViewController?.friendContent = content
            destinationViewController?.friendName = friend.name

            if UIImage(named: friend.name) != nil {
                destinationViewController?.friendImage = UIImage(named: friend.name)
            } else {
                destinationViewController?.friendImage = friend.image
            }
        }
    }

    func setUpSearchBar() {
        friendSearchBar.delegate = self
    }

    private func makeFriendsList() {

        for element in someFriends {
            friendsNames.append(String(element.name.first!))

            guard dictFriends[String(element.name.first!)] == nil else {
                dictFriends[String(element.name.first!)]?.append(element)
                continue
            }
            dictFriends.updateValue([element], forKey: String(element.name.first!))
        }
        friendsNames = Array(Set(friendsNames)).sorted()
    }
}

extension AllFriendsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        friendSearch = friendsNames.filter({$0.prefix(searchText.count) == searchText})
        searchFriendDict = dictFriends.filter({$0.key.prefix(searchText.count) == searchText})
        searching = true
        tableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tableView.reloadData()
    }
}
