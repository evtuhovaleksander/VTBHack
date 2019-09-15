//
//  AddItemViewController.swift
//  VTBHack
//
//  Created by Кирилл Володин on 15/09/2019.
//  Copyright © 2019 RxProject. All rights reserved.
//

import UIKit

protocol AddItemViewControllerDelegate: class {
    func didCreateItem()
}

class AddItemViewController: UIViewController {
    
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var quantityTextField: UITextField!
    
    weak var delegate: AddItemViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func closeTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addTapped(_ sender: Any) {
        let price = priceTextField.text ?? "10"
        let name = amountTextField.text
        let quantity = quantityTextField.text
        let item = Item(price: Int(price), title: name)
    }
}
