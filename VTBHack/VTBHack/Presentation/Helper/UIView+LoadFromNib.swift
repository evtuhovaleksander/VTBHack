//
//  UIView+LoadFromNib.swift
//  VTBHack
//
//  Created by Aleksander Evtuhov on 14/09/2019.
//  Copyright © 2019 RxProject. All rights reserved.
//

import UIKit

extension UIView {
    class func loadFromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}

extension UIViewController {
    func showError(_ error: String) {
        let alert = UIAlertController(title: "Ошибка",
                                      message: error,
                                      preferredStyle: .alert)
        let submitAction = UIAlertAction(title: "OK", style: .default, handler: { (_) -> Void in
        })
        alert.addAction(submitAction)
        present(alert, animated: true, completion: nil)
    }
}
