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
    var filteredFriends = [User]()

    var friendsNamesFirstLetter: [String] = []
    var dictFriends: [String: [User]] = [:]
    var friendsNames = [String]()

    var friendSearch = [String]()
    var searchFriendDict: [String: [User]] = [:]

    var emptyResult = false
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
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        if emptyResult {
            return 1
        }
        if searching {
            return searchFriendDict.keys.count
        } else {
            return dictFriends.keys.count
        }
    }

    override func tableView
        (_ tableView: UITableView,
         numberOfRowsInSection section: Int
    ) -> Int {
        if emptyResult {
            return 1
        }
        if searching {
            return searchFriendDict[String(friendSearch[section].first!)]!.count
            } else {
            return dictFriends[friendsNamesFirstLetter[section]]!.count
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if emptyResult {
            return nil
        }
        if searching {
            return friendSearch[section].first?.uppercased()
        } else {
        return friendsNamesFirstLetter[section].first?.uppercased()
        }
    }

    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        if searching {
            return  Array(Set(friendSearch.compactMap{ $0.first?.uppercased() } )).sorted()
        } else {
            return Array(Set(friendsNamesFirstLetter.compactMap{$0.first?.uppercased()})).sorted()
        }
        }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FriendsTableCell.self), for: indexPath) as? FriendsTableCell else {
            preconditionFailure("Fail")
        }
        if emptyResult {
            tableView.reloadData()
            return cell
        }

        if searching {
            
            guard let friends = searchFriendDict[String(friendSearch[indexPath.section].first!)]?[indexPath.row] else
                {
                preconditionFailure("Fail")
            }

            cell.friendNameCell?.text = friends.name
            cell.friendImageCell?.image = friends.image

            cell.friendImageCell?.asCircle()
            cell.viewForShadow.asCircle()
            cell.viewForShadow?.makeShadow()

            if UIImage(named: friends.name) != nil {
                cell.friendImageCell.image = UIImage(named: friends.name)
            }

        } else {

            guard let friends = dictFriends[friendsNamesFirstLetter[indexPath.section]]?[indexPath.row] else {
                preconditionFailure("Fail")
            }

            cell.friendNameCell?.text = friends.name
            cell.friendImageCell?.image = friends.image

            cell.friendImageCell?.asCircle()
            cell.viewForShadow.asCircle()
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

            if searching {
                guard let friend = searchFriendDict[String(friendSearch[indexPath.section].first!)]?[indexPath.row] else {
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

            } else {
                guard let friend = dictFriends[friendsNamesFirstLetter[indexPath.section]]?[indexPath.row] else {
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
    }
}

//Создание списка друзей
extension AllFriendsTableViewController {
    private func makeFriendsList() {

        for element in someFriends {
            friendsNames.append(element.name)
            friendsNamesFirstLetter.append(String(element.name.first!))

            guard dictFriends[String(element.name.first!)] == nil else {
                dictFriends[String(element.name.first!)]?.append(element)
                continue
            }
            dictFriends.updateValue([element], forKey: String(element.name.first!))
        }
        friendsNamesFirstLetter = Array(Set(friendsNamesFirstLetter)).sorted()
    }
}

//Поиск
extension AllFriendsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        //Проверяем не пустая ли строка
        if searchText.isEmpty {
            searching = false
            emptyResult = false
            tableView.reloadData()
            return
        }

        friendSearch = friendsNames.filter({$0.prefix(searchText.count).lowercased() == searchText.lowercased()})
        //проверяем результаты
        if friendSearch.isEmpty {
            searching = true
            searchFriendDict.removeAll()
            emptyResult = true
            tableView.reloadData()
            return
        }
        //создаём новый словарь из элемента по первой букве
        searchFriendDict = dictFriends.filter({$0.key.lowercased() == String(searchText.first!.lowercased())})
        //в словаре удаляем ненайденные имена
        for element in searchFriendDict {
            filteredFriends = element.value.filter({$0.name.prefix(searchText.count).lowercased() == searchText.lowercased()})
            searchFriendDict.updateValue(filteredFriends, forKey: element.key)
        }

        emptyResult = false
        searching = true
        tableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        emptyResult = false
        searchBar.text = ""
        view.endEditing(true)
        tableView.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func setUpSearchBar() {
        friendSearchBar.delegate = self
    }
}
