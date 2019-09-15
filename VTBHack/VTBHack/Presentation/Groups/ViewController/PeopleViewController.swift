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
    
    func setupTableView() {
        
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
        guard let vc = stb.instantiateInitialViewController() as? PeoplePickerViewController else { return }
        vc.dataSource = ContactBookPeopleDataSource()
        present(vc, animated: true, completion: nil)
    }
    
    func openBluetooth() {
        let stb = UIStoryboard(name: "People", bundle: nil)
        guard let vc = stb.instantiateInitialViewController() as? PeoplePickerViewController else { return }
        vc.dataSource = MultiPeerPeopleDataSource()
        present(vc, animated: true, completion: nil)
    }
    
    
    func openShareDeeplink() {
        let text = "smartbill://{bill_id}"
        
        let textToShare = [text]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
    
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func addByIdentifier() {
        // обычный алерт с 1 полем ввода
    }

}
