//
//  AllGroupsTableController.swift
//  vk-login-geekbrains
//
//  Created by Aleksey on 02.04.2020.
//  Copyright © 2020 Aleksey Mikhlev. All rights reserved.
//
import Alamofire
import RealmSwift
import UIKit

class AllGroupsTableController: UITableViewController {

    @IBOutlet weak var groupSearch: UISearchBar!

    var allGroups = [Group]()

    var filteredGroups = [Group]()
    var searching = false
    var emptyResult = false

    override func viewDidLoad() {
        super.viewDidLoad()

        getGroupsList() { [weak self] allGroups in
            // сохраняем полученные данные в массиве, чтобы коллекция могла получить к ним доступ
            self?.allGroups = allGroups
            // коллекция должна прочитать новые данные
            self?.tableView?.reloadData()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

            return allGroups.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: GroupCell.self), for: indexPath) as? GroupCell else {
            preconditionFailure("Fail")
        }
        cell.groupTitleCell.text = allGroups[indexPath.row].title
        return cell
    }
}

extension AllGroupsTableController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            searching = false
            emptyResult = false
            print(searchText)
            tableView.reloadData()
            return
        }

        filteredGroups = allGroups.filter({$0.title.prefix(searchText.count).lowercased() == searchText.lowercased()})

        emptyResult = false
        searching = true
        tableView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        emptyResult = false
        searchBar.text = ""
        tableView.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
}

func getGroupsList(completion: @escaping ([Group]) -> Void) {
    let baseUrl = "https://api.vk.com"
    let path = "/method/groups.get"

    let parameters: Parameters = [
        "extended": "1",
        "v": "5.52",
        "access_token": Session.instance.token
    ]

    let searchUrl = baseUrl + path

    var some = [Group]()
    AF.request(searchUrl,
               method: .get,
               parameters: parameters
    ).responseData { response in
            guard let data = response.value else { return }
            do {
                print(response)

                let groups = try JSONDecoder().decode(ResultGroup.self, from: data)
                for index in 0..<groups.response.count{
                    let firstAndLast = groups.response.items[index].name

                    some.append(Group(title: firstAndLast, image: UIImage(named: "default")!))
                    saveGroupData(some)
                    completion(some)
                }
            } catch {
                print(error)
            }
    }
    //сохранение данных групп в Realm
    func saveGroupData(_ groups: [Group]) {
            do {
                let realm = try Realm()
                realm.beginWrite()
                realm.add(groups)
                try realm.commitWrite()
            } catch {
                print(error)
        }
    }

}
