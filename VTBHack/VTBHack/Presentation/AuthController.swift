//
//  AuthController.swift
//  VTBHack
//
//  Created by Aleksander Evtuhov on 14/09/2019.
//  Copyright © 2019 RxProject. All rights reserved.
//

import UIKit
import CryptoSwift


class AuthController: UIViewController {
    
    @IBOutlet var identifierField: UITextField!
    
    @IBOutlet var passwordField: UITextField!
    
    @IBOutlet var authButton: WhiteButton!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Color.authDarkBlueBackground
        authButton.setTitle("Войти", for: .normal)
        identifierField.text = "79999999999"
    }
    
    @IBAction func auth(_ sender: Any) {
        guard let identifier = identifierField.text else { return }
        ServiceLayer.shared.accountService.obtainSession { result in
            switch result {
            case .error(let error):
                print(error)
                let alert = UIAlertController(title: "Ошибка", message: error, preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                self.present(alert, animated: true)
            case .success(let model):
                dump(model)
                
                let address = identifier.sha256()
                ServiceLayer.shared.accountService.obtainAccountBalance(address: address) { result in
                    switch result {
                    case .error(let error):
                        print(error)
                        let alert = UIAlertController(title: "Ошибка", message: error, preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        
                        self.present(alert, animated: true)
                    case .success(let model):
                        dump(model)
                    }
                }
            }
        }
    }
}
