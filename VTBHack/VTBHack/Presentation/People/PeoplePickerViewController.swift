//
//  PeoplePickerViewController.swift
//  VTBHack
//
//  Created by Aleksander Evtuhov on 14/09/2019.
//  Copyright © 2019 RxProject. All rights reserved.
//

import UIKit
import MultipeerConnectivity

protocol PeoplePickerViewControllerDelegate: class {
    func picked(contacts: [Contact])
}

class PeoplePickerViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var actionButton: UIButton!
    weak var delegate: PeoplePickerViewControllerDelegate?
    var dataSource: PeopleDataSource!
    //var dataSource = ContactBookPeopleDataSource()
    let identifier = "\(PeopleCell.self)"
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource.tableview = tableView
       actionButton.backgroundColor = UIColor.Color.darkBlue
        actionButton.setTitle("Подтвердить", for: .normal)
        actionButton.layer.cornerRadius = 27
        actionButton.clipsToBounds = true
        tableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
        view.backgroundColor = UIColor.Color.backgroundGray
        tableView.backgroundColor = .clear
        dataSource.allowReload = true
    }
    
    
    @IBAction func action(_ sender: Any) {
        delegate?.picked(contacts: dataSource.people.filter({ $0.selected }))
        navigationController?.popViewController(animated: true)
    }
}

extension PeoplePickerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! PeopleCell
        cell.configure(model: dataSource.people[indexPath.row])
        return cell
    }
}

extension PeoplePickerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        dataSource.people[indexPath.row].selected.toggle()
        tableView.reloadData()
    }
}
