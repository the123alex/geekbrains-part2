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
    var someFriends = [User]()

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

    override func viewDidLoad() {
        super.viewDidLoad()

        getFriendList() { [weak self] someFriends in
            // сохраняем полученные данные в массиве, чтобы коллекция могла получить к ним доступ
            self?.someFriends = someFriends
            // коллекция должна прочитать новые данные
           // self?.makeFriendsList()
            self?.setUpSearchBar()
            self?.tableView?.reloadData()
        }

        navigationItem.title = "Friends of \(Session.instance.token), id: \(Session.instance.id)"

        content.images.updateValue(["max", "max2", "max3" ], forKey: "Max")
        content.images.updateValue(["boris1", "boris2"], forKey: "Boris")
        content.images.updateValue(
            ["red1", "red2", "red3", "red4", "red5", "red6" ],
            forKey: "Anna"
        )
        content.images.updateValue(
            ["red1", "red2", "red3", "red4", "red5", "red6" ],
            forKey: "Ivan"
        )
        content.images.updateValue(
            ["red1", "red2", "red3", "red4", "red5", "red6" ],
            forKey: "Bob"
        )
        content.images.updateValue(
            ["red1", "red2", "red3", "red4", "red5", "red6" ],
            forKey: "Carl"
        )

    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView
        (_ tableView: UITableView,
         numberOfRowsInSection section: Int
    ) -> Int {
        return someFriends.count
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
         let friends = someFriends[indexPath.row]

            cell.friendNameCell?.text = friends.name
            cell.friendImageCell?.image = friends.image

            cell.friendImageCell?.asCircle()
            cell.viewForShadow.asCircle()
            cell.viewForShadow?.makeShadow()

            if UIImage(named: friends.name) != nil {
                cell.friendImageCell.image = UIImage(named: friends.name)
        }
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let indexPath = tableView.indexPathForSelectedRow {

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


//получение списка друзей
func getFriendList(completion: @escaping ([User]) -> Void) {
    let baseUrl = "https://api.vk.com"
    let path = "/method/friends.get"
    let parameters: Parameters = [
        "fields": "crop_photo,crop",
        "v": "5.52",
        "access_token": Session.instance.token
    ]

    let searchUrl = baseUrl + path

    var imageResult = UIImage(named: "default")!
    AF.request(searchUrl,
               method: .get,
               parameters: parameters
    ).responseData { response in
            guard let data = response.value else { return }
            do {
                print(response)

                let users = try JSONDecoder().decode(ResultUser.self, from: data)
                for index in 0..<users.response.count{
//                    DispatchQueue.main.async {
//
//                    if users.response.items[index].crop_photo != nil,
//                        users.response.items[index].crop_photo?.photo.photo_807 != nil {
//                    if let imageURL  = users.response.items[index].crop_photo!.photo.photo_807 {
//                        let data = try? Data(contentsOf: imageURL)
//                        if data != nil {
//                            print(index)
//                            let image = UIImage(data: data!)
//                                imageResult = image!
//                            }
//                        }
//                        }
//                    }
                    let firstAndLast = "\(users.response.items[index].first_name) \(users.response.items[index].last_name)"

                    self.some.append(User.init(name: firstAndLast))
                    self.saveUserData(self.some)
                    completion(self.some)
                }
            } catch {
                print(error)
            }
    }
}

    //сохранение данных пользователя в Realm
        func saveUserData(_ users: [User]) {
    // обработка исключений при работе с хранилищем
            do {
    // получаем доступ к хранилищу
                let realm = try Realm()
    // начинаем изменять хранилище
                realm.beginWrite()
    // кладем все объекты класса пользователей в хранилище
            realm.add(users)
    // завершаем изменения хранилища
                try realm.commitWrite()
            } catch {
    // если произошла ошибка, выводим ее в консоль
                print(error)
            }
        }

}

