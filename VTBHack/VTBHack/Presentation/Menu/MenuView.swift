//
//  MainView.swift
//  VTBHack
//
//  Created by Roman Nordshtrem on 14/09/2019.
//  Copyright © 2019 RxProject. All rights reserved.
//

import UIKit

class MenuView: UIView {

    @IBOutlet var button: UIButton!
    var action: VoidBlock?
    @IBOutlet var separator: UIView!
    
    @IBAction func buttonTapped(_ sender: Any) {
        action?()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}

