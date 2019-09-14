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
        //auth(self)
    }
    
    func showError(_ error: String) {
        let alert = UIAlertController(title: "Ошибка", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func getFSID() {
        ServiceLayer.shared.accountService.obtainSession { result in
            switch result {
            case .error(let error):
                print(error)
                self.showError(error)
            case .success(let model):
                dump(model)
                self.getAddress()
            }
        }
    }
        
    func getAddress() {
        guard let identifier = identifierField.text else { return }
        let identifierSha = identifier.sha256()
        ServiceLayer.shared.accountService.obtainAccountAddress(identifier: identifierSha) { result in
            switch result {
            case .error(let error):
                self.showError(error)
            case .success(let model):
                dump(model)
                ServiceLayer.shared.infoService.accountAdress = model.data.address
                self.getBalance(address: model.data.address)
            }
        }
    }
    
    func getBalance(address: String) {
        ServiceLayer.shared.accountService.obtainAccountBalance(address: address) { result in
            switch result {
            case .error(let error):
                self.showError(error)
            case .success(let model):
                dump(model)
                ServiceLayer.shared.infoService.accountInfo = model
                ServiceLayer.shared.infoService.identifier = self.identifierField.text ?? ""
                ServiceLayer.shared.multiPeerService = MultiPeerService()
                self.performSegue(withIdentifier: "auth", sender: nil)
            }
        }
    }
    
    
    @IBAction func auth(_ sender: Any) {
        getFSID()
    }
}
