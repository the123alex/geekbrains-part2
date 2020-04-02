//
//  AllGroupsTableController.swift
//  vk-login-geekbrains
//
//  Created by Aleksey on 02.04.2020.
//  Copyright © 2020 Aleksey Mikhlev. All rights reserved.
//

import UIKit

class AllGroupsTableController: UITableViewController {
    var allGroups = [
        Group(title: "First group", countSubscribers: 24, image: UIImage(named: "First group")!),
        Group(title: "Second group", countSubscribers: 100, image: UIImage(named: "Second group")!),
        Group(title: "Third group", countSubscribers: 200_000, image: UIImage(named: "Third group")!),
        Group(title: "Fourth group", countSubscribers: 50_000, image: UIImage(named: "Fourth group")!)
    ]

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
        return allGroups.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: GroupCell.self), for: indexPath) as? GroupCell else {
            preconditionFailure("Fail")
        }

        let groups = allGroups[indexPath.row]
        cell.groupTitleCell?.text = groups.title
        cell.groupImageCell?.image = groups.image
        return cell
    }
}
