//
//  FavouriteGroupsTableController.swift
//  vk-login-geekbrains
//
//  Created by Aleksey on 02.04.2020.
//  Copyright © 2020 Aleksey Mikhlev. All rights reserved.
//

import UIKit

class FavouriteGroupsTableController: UITableViewController {
    var myGroups = [Group]()
    var myGroupsTitles = [String]()

    @IBAction func addGroup(segue: UIStoryboardSegue) {

        if segue.identifier == "addGroup" {
                // Получаем ссылку на контроллер, с которого осуществлен переход
            guard let allGroupsController = segue.source as? AllGroupsTableController else { return }
            // Получаем индекс выделенной ячейки
            if let indexPath = allGroupsController.tableView.indexPathForSelectedRow {
                // Получаем группу по индексу
                let group = allGroupsController.allGroups[indexPath.row]
                // Проверяем, что такой группы нет в списке
                if !myGroupsTitles.contains(group.title) {
                    myGroups.append(group)
                    myGroupsTitles.append(group.title)
                }
            }
            tableView.reloadData()
        }
    }

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
        return myGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: GroupCell.self), for: indexPath) as? GroupCell else {
            preconditionFailure("Fail")
        }
        let groups = myGroups[indexPath.row]
        cell.groupTitleCell?.text = groups.title
        cell.groupImageCell?.image = groups.image
        return cell
       }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
        // Delete the row from the data source
            myGroupsTitles.remove(at: indexPath.row)
            myGroups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
