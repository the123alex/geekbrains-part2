//
//  AllFriendsTableViewController.swift
//  vk-login-geekbrains
//
//  Created by Aleksey on 31.03.2020.
//  Copyright © 2020 Aleksey Mikhlev. All rights reserved.
//
import Alamofire
import RealmSwift
import UIKit

class AllFriendsTableViewController: UITableViewController {
    @IBOutlet weak var friendSearchBar: UISearchBar!
    var someFriends: Results<ItemsUser>?
    var token: NotificationToken?

    //var someFriends = [User]()

    var content: Content = Content(images: [:], likes: [:])
    var filteredFriends = [User]()

    var friendsNamesFirstLetter: [String] = []
    var dictFriends: [String: [User]] = [:]
    var friendsNames = [String]()

    var friendSearch = [String]()
    var searchFriendDict: [String: [User]] = [:]

    var emptyResult = false
    var searching = false
    var some = [User]()
    var imageResult = UIImage(named: "default")!

    override func viewDidLoad() {
        super.viewDidLoad()
        pairTableAndRealm()
        //loadData()
        getFriendList()

        navigationItem.title = "Friends of \(Session.instance.token), id: \(Session.instance.id)"
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView
        (_ tableView: UITableView,
         numberOfRowsInSection section: Int
    ) -> Int {
        return someFriends?.count ?? 0
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
        let friends = someFriends![indexPath.row]

        cell.friendNameCell?.text = friends.first_name
           // cell.friendImageCell?.image = UIImage(named: "")

            cell.friendImageCell?.asCircle()
            cell.viewForShadow.asCircle()
            cell.viewForShadow?.makeShadow()

//            if UIImage(named: friends.name) != nil {
//                cell.friendImageCell.image = UIImage(named: friends.name)
//        }
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        if let indexPath = tableView.indexPathForSelectedRow {
//
//            if searching {
//                guard let friend = searchFriendDict[String(friendSearch[indexPath.section].first!)]?[indexPath.row] else {
//                    preconditionFailure("Fail")
//                }
//                let destinationViewController = segue.destination as? OneFriendCollectionViewController
//                destinationViewController?.friendContent = content
//                destinationViewController?.friendName = friend.name
//
//                if UIImage(named: friend.name) != nil {
//                    destinationViewController?.friendImage = UIImage(named: friend.name)
//                } else {
//                    destinationViewController?.friendImage = friend.image
//                }
//
//            } else {
//                guard let friend = dictFriends[friendsNamesFirstLetter[indexPath.section]]?[indexPath.row] else {
//                    preconditionFailure("Fail")
//                }
//                let destinationViewController = segue.destination as? OneFriendCollectionViewController
//                destinationViewController?.friendContent = content
//                destinationViewController?.friendName = friend.name
//
//                if UIImage(named: friend.name) != nil {
//                    destinationViewController?.friendImage = UIImage(named: friend.name)
//                } else {
//                    destinationViewController?.friendImage = friend.image
//                }
//            }
//        }
        
    }
}

//Создание списка друзей
extension AllFriendsTableViewController {
    private func makeFriendsList() {
//        for element in someFriends {
//            friendsNames.append(element.name)
//            friendsNamesFirstLetter.append(String(element.name.first!))
//
//            guard dictFriends[String(element.name.first!)] == nil else {
//                dictFriends[String(element.name.first!)]?.append(element)
//                continue
//            }
//            dictFriends.updateValue([element], forKey: String(element.name.first!))
//        }
//        friendsNamesFirstLetter = Array(Set(friendsNamesFirstLetter)).sorted()
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


//получение списка друзей
func getFriendList() {
    let baseUrl = "https://api.vk.com"
    let path = "/method/friends.get"
    let parameters: Parameters = [
        "fields": "crop_photo,crop",
        "v": "5.52",
        "access_token": Session.instance.token
    ]

    let searchUrl = baseUrl + path

    AF.request(searchUrl,
               method: .get,
               parameters: parameters
    ).responseData { response in
            guard let data = response.value else { return }
            do {
                print(response)

                let users = try JSONDecoder().decode(ResultUser.self, from: data)
                let userPhoto = users
                for index in 0..<users.response.count{

                    DispatchQueue.global(qos: .background).async {

                        if userPhoto.response.items[index].crop_photo != nil,
                            userPhoto.response.items[index].crop_photo?.photo!.photo_807 != nil {
                            if let imageURL  = userPhoto.response.items[index].crop_photo!.photo!.photo_807 {
                                let data = try? Data(contentsOf: imageURL)
                                if data != nil {
                                    //print(index)
                                    let image = UIImage(data: data!)
                                    self.imageResult = image!
                                    //self.some[index].image = image
                                }
                            }
                        }
                    }

                    self.saveUserData(users.response.items, index: index)
                }
            } catch {
                print(error)
            }
    }
}

    //сохранение данных пользователя в Realm
    func saveUserData(_ users: [ItemsUser], index: Int) {
            do {

                print(users)
                let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
                let realm = try Realm(configuration: config)
                print(realm.configuration.fileURL)
//                guard let test = realm.object(ofType: ItemsUser.self, forPrimaryKey: users[index].id) else {
//                    return
//                }

                let test1 = realm.objects(ItemsUser.self)
               // print(realm.objects(ItemsUser.self).first!.first_name)
                //let test = realm.object(ofType: ItemsUser.self, forPrimaryKey: users.first!.id)
                realm.beginWrite()
                //if test != nil {
                //realm.delete(test1)
                realm.add(users, update: .modified)
                //    realm.add(users, update: .modified)
                //} else {
                  //  realm.add(users)
                //i}

                try realm.commitWrite()
            } catch {
                print(error)
        }
    }
//    func loadData() {
//        do {
//            let realm = try? Realm()
//            let users = realm!.objects(ItemsUser.self)
////            for element in Array(users) {
////               // self.someFriends.append(User(name: element.first_name + " " + element.last_name))
////            }
//            tableView.reloadData()
//        } catch {
//            print(error)
//        }
//    }

    func pairTableAndRealm() {
            guard let realm = try? Realm() else { return }
        print(realm.configuration.fileURL)
            someFriends = realm.objects(ItemsUser.self)
            token = someFriends!.observe { [weak self] (changes: RealmCollectionChange) in
                guard let tableView = self?.tableView else { return }
                switch changes {
                case .initial:
                    tableView.reloadData()
                case .update(let dataUsers, let deletions, let insertions, let modifications):
                    print(dataUsers.count)
                    tableView.reloadData()
//                    tableView.beginUpdates()
//
//                    tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
//                                         with: .automatic)
//                    tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
//                                         with: .automatic)
//                    tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
//                                         with: .automatic)
//
//                    tableView.endUpdates()
                case .error(let error):
                    fatalError("\(error)")
                }
            }
        }
}
