//
//  GroupsViewController.swift
//  VTBHack
//
//  Created by Кирилл Володин on 14/09/2019.
//  Copyright © 2019 RxProject. All rights reserved.
//

import UIKit

class GroupsViewController: UIViewController {
    
    @IBOutlet weak var addBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    private let cellID = "\(GroupCell.self)"
    private let headerID = "\(GroupSectionView.self)"
    private let segueID = "toMain"
    
    private let model = GroupDatasource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: headerID, bundle: nil), forHeaderFooterViewReuseIdentifier: headerID)
    }
    
   
    
}

extension GroupsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerID) as? GroupSectionView
        let title = section == 0 ? "АКТИВНЫЕ" : "ЗАВЕРШЕННЫЕ"
        header?.headerTitle.text = title
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let group: Group
        if indexPath.section == 0 {
            group = model.activeGroups[indexPath.row]
        } else {
            group = model.completedGroups[indexPath.row]
        }
        performSegue(withIdentifier: segueID, sender: group)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let destination = segue.destination as? MainContainerViewController,
            let group = sender as? Group
        else { return }
        destination.group = group
    }
}

extension GroupsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return model.activeGroups.count
        } else {
            return model.completedGroups.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
            as? GroupCell else { return UITableViewCell() }
        let group: Group
        if indexPath.section == 0 {
            group = model.activeGroups[indexPath.row]
        } else {
            group = model.completedGroups[indexPath.row]
        }
        cell.fill(amount: "\(group.amount)", title: group.title, date: group.date)
        return cell
    }
    
}
