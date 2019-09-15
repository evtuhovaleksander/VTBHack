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
        let name = amountTextField.text ?? ""
        guard let price = Int(priceTextField.text ?? "") else { return }
        let quantity = quantityTextField.text
        let item = Item(price: price, title: name)
    }
}
