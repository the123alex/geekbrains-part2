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

    var allGroups: Results<ItemsGroup>?
    var token: NotificationToken?

    var filteredGroups = [Group]()
    var searching = false
    var emptyResult = false

    override func viewDidLoad() {
        super.viewDidLoad()
        getGroupsList()

        pairTableAndRealm()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

            return allGroups?.count ?? 0
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: GroupCell.self), for: indexPath) as? GroupCell else {
            preconditionFailure("Fail")
        }
        cell.groupTitleCell.text = allGroups![indexPath.row].name
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

    func getGroupsList() {
        let baseUrl = "https://api.vk.com"
        let path = "/method/groups.get"

        let parameters: Parameters = [
            "extended": "1",
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

                let groups = try JSONDecoder().decode(ResultGroup.self, from: data)
                saveGroupData(groups.response.items)
            } catch {
                print(error)
            }
        }
    }

    func saveGroupData(_ groups: [ItemsGroup]) {
        do {
            let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
            let realm = try Realm(configuration: config)
            let oldGroups = realm.objects(ItemsGroup.self)

            realm.beginWrite()
            oldGroups.forEach { (element) in
                if !groups.contains(element) {
                    realm.delete(element)
                }
            }
            realm.add(groups, update: .modified)
            try realm.commitWrite()
        } catch {
            print(error)
        }
}

extension AllGroupsTableController {
    func pairTableAndRealm() {
        guard let realm = try? Realm() else { return }

        allGroups = realm.objects(ItemsGroup.self)
        token = allGroups!.observe { [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.tableView else { return }
            switch changes {
            case .initial:
                tableView.reloadData()
            case .update(_, let deletions, let insertions, let modifications):
                tableView.beginUpdates()

                tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                     with: .automatic)
                tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                                     with: .automatic)
                tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                     with: .automatic)

                tableView.endUpdates()
            case .error(let error):
                fatalError("\(error)")
            }
        }
    }
}
