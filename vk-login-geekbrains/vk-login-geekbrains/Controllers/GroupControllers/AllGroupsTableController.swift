//
//  AllGroupsTableController.swift
//  vk-login-geekbrains
//
//  Created by Aleksey on 02.04.2020.
//  Copyright © 2020 Aleksey Mikhlev. All rights reserved.
//

import UIKit

class AllGroupsTableController: UITableViewController {

    @IBOutlet weak var groupSearch: UISearchBar!

    var allGroups = [
        Group(title: "First group", countSubscribers: 24, image: UIImage(named: "First group")!),
        Group(title: "Second group", countSubscribers: 100, image: UIImage(named: "Second group")!),
        Group(title: "Third group", countSubscribers: 200_000, image: UIImage(named: "Third group")!),
        Group(title: "Fourth group", countSubscribers: 50_000, image: UIImage(named: "Fourth group")!),
    ]
    var filteredGroups = [Group]()
    var searching = false
    var emptyResult = false

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if emptyResult {
            return 1
        }
        if searching {
            return filteredGroups.count
        } else {
            return allGroups.count
        }
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: GroupCell.self), for: indexPath) as? GroupCell else {
            preconditionFailure("Fail")
        }
        if emptyResult {
            tableView.resignFirstResponder()
            return cell
        }

        if searching {
            let groups = filteredGroups[indexPath.row]
            cell.groupTitleCell?.text = groups.title
            cell.groupImageCell?.image = groups.image
            return cell
        } else {
            let groups = allGroups[indexPath.row]
            cell.groupTitleCell?.text = groups.title
            cell.groupImageCell?.image = groups.image
            return cell
        }
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
