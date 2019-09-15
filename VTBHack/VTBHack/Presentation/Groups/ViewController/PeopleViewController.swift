//
//  PeopleViewController.swift
//  VTBHack
//
//  Created by Кирилл Володин on 15/09/2019.
//  Copyright © 2019 RxProject. All rights reserved.
//

import UIKit

class PeopleViewController: UIViewController {

    @IBOutlet weak var addPeopleButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        addPeopleButton.layer.cornerRadius = 27
        addPeopleButton.clipsToBounds = true
    }
    
    var model = [Contact]() {
        didSet { tableView.reloadData() }
    }
    var cellID = "\(PartnerCell.self)"
    let headerID = "\(GroupSectionView.self)"
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: headerID, bundle: nil), forHeaderFooterViewReuseIdentifier: headerID)
    }
    
    @IBAction func addPeopleTapped(_ sender: Any) {
        
        // Добавить по идентификатору
        let firstAction: VoidBlock = { [weak self] in
            self?.addByIdentifier()
        }
        
        // Выбрать из списка контактов
        let secondAction: VoidBlock = { [weak self] in
            self?.openContactsPicker()
        }
        
        // Люди рядом
        let thirdAction: VoidBlock = { [weak self] in
            self?.openBluetooth()
        }
        
        // Поделиться ссылкой чека
        let forthAction: VoidBlock = { [weak self] in
            self?.openShareDeeplink()
        }
        
        let controller = MenuViewController.getController(
            titles: [
                "Добавить по идентификатору",
                "Выбрать из списка контактов",
                "Люди рядом",
                // урл схема
                "Поделиться ссылкой счета"
            ],
            actions: [
                firstAction,
                secondAction,
                thirdAction,
                forthAction
            ]
        )
        
        present(controller, animated: true, completion: nil)
        
    }
    
    func openContactsPicker() {
        let stb = UIStoryboard(name: "People", bundle: nil)
        guard let nc = stb.instantiateInitialViewController() as? UINavigationController else { return }
        guard let vc = nc.topViewController as? PeoplePickerViewController else { return }
        vc.dataSource = ContactBookPeopleDataSource()
        vc.delegate = self
        present(nc, animated: true, completion: nil)
    }
    
    func openBluetooth() {
        let stb = UIStoryboard(name: "People", bundle: nil)
        guard let nc = stb.instantiateInitialViewController() as? UINavigationController else { return }
        guard let vc = nc.topViewController as? PeoplePickerViewController else { return }
        vc.dataSource = MultiPeerPeopleDataSource()
        present(nc, animated: true, completion: nil)
    }
    
    
    func openShareDeeplink() {
        let text = "smartbill://{bill_id}"
        
        let textToShare = [text]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
    
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func addByIdentifier() {
        let alert = UIAlertController(
            title: "Добавление по идентификатору",
            message: "",
            preferredStyle: .alert
        )
        
        alert.addTextField { (textField) in
            textField.placeholder = "Введите идентификатор"
        }
        
        alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            guard let phone = textField?.text else { return }
            let contact = Contact(phone: phone, nickName: phone, selected: true)
            self.model.append(contact)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }

}

extension PeopleViewController: PeoplePickerViewControllerDelegate {
    func picked(contacts: [Contact]) {
        model.append(contentsOf: contacts)
    }
}

extension PeopleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerID) as! GroupSectionView
        header.headerTitle.text = "Участники"
        return header
    }
}

extension PeopleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
            as? PartnerCell else { return UITableViewCell() }
        let contact = model[indexPath.row]
        cell.fill(partner: contact)
        cell.invoiceInfo.isHidden = false
        return cell
    }
}
