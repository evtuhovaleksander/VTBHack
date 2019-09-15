//
//  MainContainerViewController.swift
//  VTBHack
//
//  Created by Кирилл Володин on 14/09/2019.
//  Copyright © 2019 RxProject. All rights reserved.
//

import UIKit

class MainContainerViewController: UIViewController {
    
    // Навбар
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    // Сегментед контрол
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var containerView: UIView!
    
    var group: Group!
    
    let groupsStoryboard = UIStoryboard(name: "Groups", bundle: nil)
    
    var currentViewController: UIViewController? = nil
    
    lazy var chatViewController: UIViewController = {
        let vc = ChatController()
        return vc
    }()
    lazy var checkViewController: ItemsViewController = {
        let checkViewController = groupsStoryboard
            .instantiateViewController(withIdentifier: "CheckViewController") as! ItemsViewController
        checkViewController.delegate = self
        return checkViewController
    }()
    lazy var peopleViewController: UIViewController = {
        groupsStoryboard.instantiateViewController(withIdentifier: "PeopleViewController")
    }()
    
    lazy var viewControllers = [chatViewController, checkViewController, peopleViewController]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbar()
        setupSegmentedControl()
        showController(index: 1)
    }
    
    var isLayoutSetuped = false
    
    override func viewDidLayoutSubviews() {
        guard !isLayoutSetuped else { return }
        showController(index: 1)
        isLayoutSetuped = true
    }
    
    func setupSegmentedControl() {
        segmentedControl.selectedSegmentIndex = 1
    }
    
    func setupNavbar() {
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        dateLabel.text = group.date
        titleLabel.text = group.title
        
        let attributedString = NSMutableAttributedString(string: "\(group.amount) ₽", attributes: [
            .font: UIFont.systemFont(ofSize: 19.0, weight: .bold),
            .foregroundColor: UIColor(white: 1.0, alpha: 1.0),
            .kern: 0.04
            ])
        amountLabel.attributedText = attributedString
    }
    
    func showController(index: Int) {
        currentViewController?.remove()
        let child = viewControllers[index]
        add(child, frame: containerView.frame)
        currentViewController = child
        if index == 1 {
            //checkViewController.people = peopleViewController.
        }
    }
    
    @IBAction func segmentedValueChanged(_ sender: UISegmentedControl) {
        showController(index: sender.selectedSegmentIndex)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let iden = segue.identifier {
            if
                iden == "toAddItem",
                let dst = segue.destination as? AddItemViewController {
                dst.addBlock = { item in
                    self.checkViewController.model.items.append(item)
                    self.checkViewController.isQRCodeParsed = true
                    self.checkViewController.updateData()
                }
            }
        }
    }
}

extension MainContainerViewController: ItemsViewControllerDelegate {
    func didTapAddItem() {
        performSegue(withIdentifier: "toAddItem", sender: nil)
    }
}
